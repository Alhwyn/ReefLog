import CoreML
import SwiftUI

class FishClassifierModel {
    
    func classifyFish(image: UIImage) async -> String {
        let resizeImage = image.resizeImageTo(size: CGSize(width: 299, height: 299))
        
        guard let cvPixelBuffer = resizeImage?.convertToBuffer() else { return "Unknown"}
        
        do {
            let model = try Minnow_1(configuration: MLModelConfiguration())
            let prediction = try model.prediction(image: cvPixelBuffer)
            print(prediction.target)
            return prediction.target
        } catch let error {
            print(error.localizedDescription)
            return "Unknown"
            
        }
    }
}
