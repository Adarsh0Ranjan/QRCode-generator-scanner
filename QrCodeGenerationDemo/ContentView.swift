//
//  ContentView.swift
//  QrCodeGenerationDemo
//
//  Created by Roro Solutions on 01/02/23.
//

import SwiftUI
import CoreImage.CIFilterBuiltins

struct ContentView: View {
    @State private var name = "Adarsh"
    @State private var emailAddress = "adarsh.ranjan@roro.io"
        
    var body: some View {
        NavigationView {
            Form {
                TextField("Name", text: $name)
                    .textContentType(.name)
                    .font(.title)

                TextField("Email address", text: $emailAddress)
                    .textContentType(.emailAddress)
                    .font(.title)
                
                Image(uiImage: generateQRCode(from: "\(name)\n\(emailAddress)"))
                    .resizable()
                    .interpolation(.none)
                    .scaledToFit()
                    .frame(width: 300, height: 200)
            }
            .navigationTitle("Your code")
        }
    }
    
    // QR code generator
    func generateQRCode(from string: String) -> UIImage {
        
        //  properties to store an active Core Image context and an instance of Core Image’s QR code generator filter.
        let context = CIContext()
        let filter = CIFilter.qrCodeGenerator()
        
        // set input message for the QR code
        filter.setValue(string.data(using: .utf8), forKey: "inputMessage")
//        filter.message = Data(string.utf8)

        // Get the output image from filter and convert them to uiImage
        if let outputImage = filter.outputImage {
            if let cgimg = context.createCGImage(outputImage, from: outputImage.extent) {
                return UIImage(cgImage: cgimg)
            }
        }
        return UIImage(systemName: "xmark.circle") ?? UIImage()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
