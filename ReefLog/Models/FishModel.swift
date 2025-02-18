import CoreML
import SwiftUI

class FishClassifierModel {
    
    func classifyFish(image: UIImage) async -> String {
        let resizeImage = image.resizeImageTo(size: CGSize(width: 224, height: 224))
        
        guard let cvPixelBuffer = resizeImage?.convertToBuffer() else { return "Unknown"}
        
        do {
            let model = try MobileNetV2Int8LUT(configuration: MLModelConfiguration())
            let prediction = try model.prediction(image: cvPixelBuffer)
            print(prediction.classLabel)
            return prediction.classLabel
        } catch let error {
            print(error.localizedDescription)
            return "Unknown"
            
        }
    }
}

