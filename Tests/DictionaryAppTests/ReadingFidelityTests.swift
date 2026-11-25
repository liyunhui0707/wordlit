import Foundation
import Testing
@testable import DictionaryApp

/// Frozen before comparison. The last four cases are independent review material.
struct ReadingFidelityTests {
    private let cases = [
        ("bridge", "company", "Later, the company repaired the bridge after the storm."),
        ("both", "returned", "Neither worker returned both keys before noon."),
        ("fee", "charged", "The shop charged each visitor two dollars."),
        ("break", "took", "The driver took a short break after the alarm."),
        ("clinic", "clinic", "The clinic opened after the interview."),
        ("boxes", "boxes", "Only two of the five boxes were empty."),
        ("crane", "crane", "A crane spread its wings beside the empty boat."),
        ("decision", "made", "They made a decision after the vote, but did not announce it.")
    ]

    @Test(.enabled(if: ProcessInfo.processInfo.environment["WORDLIT_FIDELITY_OUTPUT"] != nil))
    func compareReadingRoutes() async throws {
        let env = ProcessInfo.processInfo.environment
        let model = try #require(env["WORDLIT_FIDELITY_MODEL"])
        try #require(["qwen2.5:7b", "qwen3.5:9b-q4_K_M"].contains(model))
        let file = URL(fileURLWithPath: try #require(env["WORDLIT_FIDELITY_OUTPUT"]))
        try #require(file.lastPathComponent.hasPrefix("fidelity-"))
        // Reserve the batch before sending anything. Interrupted runs cannot silently replay it.
        try Data().write(to: file, options: .withoutOverwriting)
        let handle = try FileHandle(forWritingTo: file)
        defer { try? handle.close() }
        let config = URLSessionConfiguration.ephemeral
        config.timeoutIntervalForResource = 90
        let session = URLSession(configuration: config, delegate: LocalModelRedirectGuard(), delegateQueue: nil)
        defer { session.invalidateAndCancel() }
        let provider = OllamaProvider(model: model, session: session)
        for (id, target, sentence) in cases {
            let word = try LookupRequest.captured(target: target, context: sentence, sentence: sentence,
                source: "Synthetic Books", capture: .init(reliability: .heuristic, method: .screenOCR))
            let whole = try LookupRequest.manual(target: sentence, context: "")
            for request in [word, whole] {
                let answer = try? await provider.translate(request, targetLanguage: "简体中文")
                let translation = answer?.textTranslation?.translatedText ?? answer?.exampleTranslation ?? ""
                let record = ["case": id, "route": request.task == .translation ? "text" : "word",
                              "translation": translation, "meaning": answer?.meaningInContext ?? ""]
                try handle.write(contentsOf: JSONEncoder().encode(record))
                try handle.write(contentsOf: Data([10]))
                #expect(!translation.isEmpty)
            }
        }
    }
}
