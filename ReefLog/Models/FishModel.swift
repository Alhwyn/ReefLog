import CoreML
import UIKit
import Vision

class FishClassifierModel {
    private let model: FishClassifier_1_Iteration_35
    
    init?() {
        do {
            let config = MLModelConfiguration()
            self.model = try FishClassifier_1_Iteration_35(configuration: config)
        } catch {
            print("Error initializing ML model: \(error)")
            return nil
        }
    }
    
    func classifyFish(image: UIImage) async -> String {
        let resizeImage = image.resizeImageTo(size: CGSize(width: 200, height: 200))
        
        guard let cvPixelBuffer = resizeImage?.convertToBuffer() else { return "Unknown"}
        
        do {
            let prediction = try model.prediction(image: cvPixelBuffer)
            print(prediction.target)
            return prediction.target
        } catch let error {
            print(error.localizedDescription)
            return "Unknown"
            
        }
    }
}

