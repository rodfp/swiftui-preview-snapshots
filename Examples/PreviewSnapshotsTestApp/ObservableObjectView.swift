// Copyright 2022 DoorDash, Inc.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software distributed under the License
// is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express
// or implied. See the License for the specific language governing permissions and limitations under
// the License.

import PreviewSnapshot
import SwiftUI

final class ObservableObjectViewModel: ObservableObject {
    @Published var input = ""
    @Published var errorMessage: String?
    
    func validate() {
        if input.count < 5 {
            errorMessage = "Message Too Short"
        } else {
            errorMessage = nil
        }
    }
}

struct ObservableObjectView: View {
    @ObservedObject var viewModel: ObservableObjectViewModel
    
    var body: some View {
        VStack(spacing: 8) {
            TextField("Input", text: $viewModel.input)
            
            if let errorMessage = viewModel.errorMessage {
                Text(errorMessage)
                    .font(.caption)
                    .foregroundColor(.red)
            }
            
            Button("Submit") {
                viewModel.validate()
            }
        }
        .padding(8)
    }
}

struct ObservableObjectView_Previews: PreviewProvider {
    static var previews: some View {
        snapshots.previews.previewLayout(.sizeThatFits)
    }
    
    static var snapshots: PreviewSnapshots<ObservableObjectViewModel> {
        let empty = ObservableObjectViewModel()
        
        let tooShort = ObservableObjectViewModel()
        tooShort.input = "Hi"
        tooShort.validate()
        
        let valid = ObservableObjectViewModel()
        valid.input = "Hello World"
        valid.validate()
        
        return PreviewSnapshots(
            configurations: [
                .init(name: "Empty", state: empty),
                .init(name: "Too Short", state: tooShort),
                .init(name: "Valid", state: valid),
            ],
            configure: {
                ObservableObjectView(viewModel: $0)
            }
        )
    }
}
