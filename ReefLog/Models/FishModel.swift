import CoreML
import Vision
import SwiftUI

class FishClassifierModel {
    private let coreMLModel: Minnow_1
    private let visionModel: VNCoreMLModel
    
    init() {
        do {
            let config = MLModelConfiguration()
            self.coreMLModel = try Minnow_1(configuration: config)
            self.visionModel = try VNCoreMLModel(for: coreMLModel.model)
            
            // Log model input details
            if let inputs = coreMLModel.model.modelDescription.inputDescriptionsByName["image"] {
                print("Model input: \(inputs)")
            } else {
                print("No input named 'image' found")
            }
        } catch {
            fatalError("Failed to load Minnow_1 model: \(error.localizedDescription)")
        }
    }
    
    // Original Core ML approach
    func classifyFishCoreML(image: UIImage) async -> String {
        guard let resizedImage = image.resizeImageTo(size: CGSize(width: 299, height: 299)) else {
            print("Resize failed")
            return "Unknown"
        }
        
        guard let pixelBuffer = resizedImage.convertToBuffer() else {
            print("Buffer conversion failed")
            return "Unknown"
        }
        
        do {
            let prediction = try coreMLModel.prediction(image: pixelBuffer)
            print("Core ML Prediction: \(prediction.target)")
            return prediction.target
        } catch {
            print("Core ML Prediction failed: \(error.localizedDescription)")
            return "Unknown"
        }
    }
    
    // Vision approach
    func classifyFishVision(image: UIImage) async -> String {
        guard let resizedImage = image.resizeImageTo(size: CGSize(width: 299, height: 299)) else {
            print("Resize failed")
            return "Unknown"
        }
        
        guard let cgImage = resizedImage.cgImage else {
            print("Failed to get CGImage")
            return "Unknown"
        }
        
        let request = VNCoreMLRequest(model: visionModel) { request, error in
            if let error = error {
                print("Vision request failed: \(error.localizedDescription)")
            }
        }
        
        let handler = VNImageRequestHandler(cgImage: cgImage, options: [:])
        
        return await withCheckedContinuation { continuation in
            do {
                try handler.perform([request])
                guard let results = request.results as? [VNClassificationObservation],
                      let topResult = results.first else {
                    print("No classification results")
                    continuation.resume(returning: "Unknown")
                    return
                }
                print("Vision prediction: \(topResult.identifier)")
                continuation.resume(returning: topResult.identifier)
            } catch {
                print("Vision perform failed: \(error.localizedDescription)")
                continuation.resume(returning: "Unknown")
            }
        }
    }
}
