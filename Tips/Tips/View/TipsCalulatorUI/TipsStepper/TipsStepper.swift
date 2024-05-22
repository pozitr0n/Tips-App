//
//  TipsStepper.swift
//  Tips
//
//  Created by Raman Kozar on 22/05/2024.
//

import SwiftUI

struct TipsStepper: View {
    
    // Main properties
    var currentWidth: CGFloat = 150
    var minimumValue: Int = 1
    var maximumValue: Int = 50
    
    @Binding var value: Int
    @State private(set) var offsetOfLabel: CGSize = .zero
    @State private(set) var directionDrag: ButtonDirection = .none

    var body: some View {
        
        ZStack {
            
            // Control segment view
            creatingControlSegmentView()
                .animation(animationSpring, value: containerOffsetForControls)
            
            // Label view
            creatingLabelView()
                .animation(animationSpring, value: offsetOfLabel)
                .highPriorityGesture (
                    
                    DragGesture()
                        .onChanged { value in
                            updatingDragLocation(with: value.translation)
                            updatingOffset(with: value)
                        }
                        .onEnded { _ in
                            self.updatingValueOfTipsStepper()
                        }
                    
                )
            
        }
        
    }
    
}

private extension TipsStepper {
    
    private func creatingControlSegmentView() -> some View {
        
        HStack(spacing: elementsSpacing) {
            
            MainButton(
                imageSystemName: "minus",
                imageSize: frameSizeForControls,
                propertyIsActive: directionDrag == .left,
                propertyOpacity: leftOpacityForControls,
                buttonAction: doDecreaseValue
            )
            
            MainButton(
                imageSystemName: "xmark",
                imageSize: frameSizeForControls,
                propertyIsActive: directionDrag == .down,
                propertyOpacity: opacityForControls
            )
            .allowsHitTesting(false)
            
            MainButton(
                imageSystemName: "plus",
                imageSize: frameSizeForControls,
                propertyIsActive: directionDrag == .right,
                propertyOpacity: rightOpacityForControls,
                buttonAction: doIncreaseValue
            )
            
        }
        .padding(.horizontal, elementsSpacing)
        .background(
            RoundedRectangle(cornerRadius: containerCornerRadiusForControls)
                .fill(Color.controlBackground)
                .overlay(
                    Color.black.opacity(containerOpacityForControls)
                        .clipShape(RoundedRectangle(cornerRadius: containerCornerRadiusForControls))
                )
                .frame(width: currentWidth + addWidth, height: containerHeigthForControls)
        )
        .offset(containerOffsetForControls)
        
    }
    
    private func creatingLabelView() -> some View {
        
        ZStack {
            
            Circle()
                .fill(Color.labelBackground)
                .frame(width: labelSize, height: labelSize)
            
            Text("\(value)")
                .foregroundColor(.textButtonColorBackground)
                .font(.system(size: labelFontSize, weight: .semibold, design: .rounded))
            
        }
        .drawingGroup()
        .shadow(color: .black.opacity(0.3), radius: 3, x: 0, y: 5)
        .contentShape(Circle())
        .onTapGesture {
            self.value += 1
        }
        .offset(self.offsetOfLabel)
        
    }
    
}

private extension TipsStepper {
    
    private func updatingDragLocation(with translation: CGSize) {
        
        withAnimation {
            
            if translation.height <= 0 {
               
                if translation.width > 10 {
                    
                    self.directionDrag = .right
                    
                } else if translation.width < 10 {
                    
                    self.directionDrag = .left
                    
                }
                
            } else if self.directionDrag == .none {
                self.directionDrag = .down
            }
            
        }
        
    }
    
    private func updatingOffset(with value: DragGesture.Value) {
       
        var newWidth: CGFloat = 0
        
        if value.translation.width > 0 {
            
            newWidth = min(value.translation.width * 0.75, currentWidth / 2 - (labelSize / 2))
            
        } else if value.translation.width < 0 {
            
            newWidth = max((value.translation.width * 0.75), -((currentWidth / 2) - (labelSize / 2)))
            
        }
        
        let newHeight = min(value.translation.height * 0.75, (containerHeigthForControls * 0.8))
        
        withAnimation {
            self.offsetOfLabel = .init(width: self.directionDrag  == .down ? 0 : newWidth, height: self.directionDrag == .down ? newHeight : 0)
        }
        
    }
    
    private func updatingValueOfTipsStepper() {
        
        switch directionDrag {
        case .none:
            break
        case .left:
            self.doDecreaseValue()
        case .right:
            self.doIncreaseValue()
        case .down:
            self.doReset()
        }
        
        withAnimation {
            self.offsetOfLabel = .zero
            self.directionDrag = .none
        }
        
    }
    
}

private extension TipsStepper {
    
    private func doDecreaseValue() {
        if self.value != minimumValue {
            self.value -= 1
        }
    }
    
    private func doIncreaseValue() {
        if self.value < maximumValue {
            self.value += 1
        }
    }
    
    private func doReset() {
        self.value = 1
    }
    
}

