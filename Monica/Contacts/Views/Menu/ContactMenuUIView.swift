//
//  SwiftUIView.swift
//  Monica
//
//  Created by Julien Hamon on 2020-01-15.
//  Copyright © 2020 julien hamon. All rights reserved.
//

import SwiftUI
import MessageUI

struct ContactMenuUIView: View {

    @ObservedObject var viewModel: ContactMenuViewModel
    @EnvironmentObject var showModal: ShowModal

    private let messageComposeDelegate = MessageDelegate()

    var body: some View {
        ZStack {
            Color("GrayMenuBackground")
                .edgesIgnoringSafeArea(.all)

            ScrollView {
            VStack {
                HStack(alignment: .top, content:{

                    UrlImageView(url: viewModel.imageURL)
                        .clipShape(Circle())
                        .frame(width: 36, height: 36)
                        .padding(.leading, 15)

                    VStack(alignment: .leading) {
                        Text("What do you want to do?")
                            .foregroundColor(Color.black)
                            .font(.system(size: 15, weight: .semibold, design: .rounded))
                        Text(self.viewModel.completeName)
                            .foregroundColor(Color("Body"))
                            .font(.system(size: 13, weight: .regular, design: .rounded))
                    }.padding(.leading, 10)

                    Spacer()

                    Button(action: {
                        self.showModal.modalViewModel = nil
                    }) {
                        Image("close")
                            .foregroundColor(Color("LabelLightSecondary")).frame(width: 30, height: 30)

                    }
                    .background(Color("FillLightTertiary"))
                    .clipShape(Circle())
                    .padding(.trailing, 15)
                })
                    .padding(.top, 15)

                ForEach (viewModel.cellsMenu[0] ?? []){
                    self.constructCell(index: $0.id, name: $0.name, number: self.viewModel.cellsMenu[0]?.count ?? 0)
                }

                ForEach (viewModel.cellsMenu[1] ?? []){
                    self.constructCell(index: $0.id, name: $0.name,number: self.viewModel.cellsMenu[1]?.count ?? 0)
                }
            }
            .padding(.bottom, 15)
            .background(Color("GrayBackground"))
            .padding(.top, 400)
            .onAppear(perform: {self.viewModel.apply(.onAppear)})
            }

        }
    }

    private func constructCell(index:Int, name:String, number:Int)-> some View {

        var cornerRadius:CGFloat = 0
        var corners = UIRectCorner()
        var height :CGFloat = 1

        if index == 1 {
            cornerRadius = 8
            corners = [.topRight,.topLeft]
        }
        else if index == number {
            cornerRadius = 8
            corners = [.bottomLeft,.bottomRight]
            height = 10

        }

        return Button(action: {
            self.presentMessageCompose()
        }) {
            VStack{
            MenuCellView(data: name,
                       cornerRadius: cornerRadius,
                       corners: corners)
            Spacer()
                .frame(height: height)

            }
        }
    }
}

extension ContactMenuUIView {

    /// Delegate for view controller as `MFMessageComposeViewControllerDelegate`
    private class MessageDelegate: NSObject, MFMessageComposeViewControllerDelegate {
        func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
            // Customize here
            controller.dismiss(animated: true)
        }

    }

    /// Present an message compose view controller modally in UIKit environment
    private func presentMessageCompose() {
        guard MFMessageComposeViewController.canSendText() else {
            return
        }
        let vc = UIApplication.shared.keyWindow?.rootViewController

        let composeVC = MFMessageComposeViewController()
        composeVC.messageComposeDelegate = messageComposeDelegate

        vc?.present(composeVC, animated: true)
    }
}

#if DEBUG
struct ContactMenuUIView_Previews: PreviewProvider {
    @State static var show = false

    static var previews: some View {
        ContactMenuUIView(viewModel: .init(contact: nil, contactFields: []))
    }
}
#endif
