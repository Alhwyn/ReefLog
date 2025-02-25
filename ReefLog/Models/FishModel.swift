import CoreML
import SwiftUI

class FishClassifierModel {
    /// This function is the main function to call to classify the fish images
    /// there is a problem with minnow-1 tried everthing I can fixing unfortunalty just have to ise the MobileNetV2Int8LUT
    
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
