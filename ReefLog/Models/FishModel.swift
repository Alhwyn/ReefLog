import CoreML
import UIKit

class FishClassifierModel {
    private let model: FishClassifier
    
    init?() {
        do {
            let config = MLModelConfiguration()
            self.model = try FishClassifier(configuration: config)
        } catch {
            print("Error initializing ML model: \(error)")
            return nil
        }
    }
    
    
    func classifyFish(image: UIImage?) async -> String {
        guard let pixelBuffer = image?.resize(size: CGSize(width: 1000, height: 1000))?
                .getCVPixelBuffer() else {
            return "Unknown"
        }

        do {
            let prediction = try model.prediction(image: pixelBuffer)
            print("Prediction: \(prediction.target), Confidence: \(prediction.targetProbability)")
            return prediction.target
        } catch {
            print("Error during model prediction: \(error)")
            return "Unknown"
        }
    }
}

