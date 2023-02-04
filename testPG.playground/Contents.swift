let url = URL(string: "https://api.nasa.gov/planetary/apod?api_key=DEMO_KEY")!
Task {
    let (data, response) = try await URLSession.shared.data(from: url)
    if let httpResponse = response as? HTTPURLResponse,
        httpResponse.statusCode == 200,
        let string = String(data: data, encoding: .utf8) {
            print(string)
    }
}
