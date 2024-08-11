import Foundation
import Combine

class APIService: ObservableObject {
    static let shared = APIService()
    
    private let baseURL = "http://34.64.220.15:8000/chatgpt/"
    
    private var csrfToken: String?
    
    // CSRF 토큰을 가져오는 메서드
    func fetchCSRFToken() -> AnyPublisher<String, URLError> {
        guard let url = URL(string: "http://34.64.220.15:8000") else {
            return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        return URLSession.shared.dataTaskPublisher(for: request)
            .map(\.response)
            .compactMap { response in
                guard let httpResponse = response as? HTTPURLResponse,
                      let cookies = httpResponse.allHeaderFields["Set-Cookie"] as? String else {
                    return nil
                }
                return self.extractCSRFToken(from: cookies)
            }
            .mapError { $0 as? URLError ?? URLError(.unknown) } // 타입 변환
            .eraseToAnyPublisher()
    }
    
    // CSRF 토큰을 추출하는 메서드
    private func extractCSRFToken(from cookieHeader: String) -> String? {
        let cookies = cookieHeader.split(separator: ";")
        for cookie in cookies {
            let components = cookie.split(separator: "=")
            if components.count == 2 {
                let key = components[0].trimmingCharacters(in: .whitespaces)
                let value = components[1].trimmingCharacters(in: .whitespaces)
                if key == "csrftoken" {
                    return value
                }
            }
        }
        return nil
    }
    
    func fetchResponse(prompt: String) -> AnyPublisher<String, URLError> {
        guard let url = URL(string: baseURL) else {
            return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
        }
        
        // CSRF 토큰 가져오기
        return fetchCSRFToken()
            .flatMap { csrfToken -> AnyPublisher<String, URLError> in
                var request = URLRequest(url: url)
                request.httpMethod = "POST"
                request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
                request.setValue(csrfToken, forHTTPHeaderField: "X-CSRFToken")
                
                let body = "prompt=\(prompt.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")"
                request.httpBody = body.data(using: .utf8)
                
                return URLSession.shared.dataTaskPublisher(for: request)
                    .map(\.data)
                    .handleEvents(receiveOutput: { data in
                        // 디버깅을 위해 데이터 출력
                        if let jsonString = String(data: data, encoding: .utf8) {
                            print("Response Data: \(jsonString)")
                        }
                    })
                    .decode(type: Response.self, decoder: JSONDecoder())
                    .map { $0.response }
                    .mapError { $0 as? URLError ?? URLError(.unknown) } // 타입 변환
                    .eraseToAnyPublisher()
            }
            .eraseToAnyPublisher()
    }
}

// 서버 응답을 처리할 구조체
struct Response: Decodable {
    let response: String
}
