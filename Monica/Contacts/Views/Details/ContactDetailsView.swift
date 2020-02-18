//
//  ContactDetailsView.swift
//  Monica
//
//  Created by Julien Hamon on 2019-11-23.
//  Copyright © 2019 julien hamon. All rights reserved.
//

import SwiftUI
import Lottie

struct ContactDetailsView: View {

    @ObservedObject var viewModel: ContactDetailsViewModel

    private let spacing: CGFloat = 15

    var body: some View {
        switch viewModel.listState {
        case .error(let error):
            return AnyView(
                VStack {
                    Text(error.localizedDescription)
                        .lineLimit(nil)

                    Button(action: {
                        // do something
                    }) {
                        Text("Retry")
                    }
            })
        case .items:
            if let contact = viewModel.contact {
                return AnyView(
                    content(contact: contact)
                )
            } else {
                return AnyView(Text("No data"))
            }
        case .loading:
            return AnyView(
                VStack(alignment: .center) {
                    LottieView(filename: "loading")
                }
                .onAppear {
                    self.viewModel.apply(.onAppear)
            })
        }
    }

    private func calculateHeight(minHeight: CGFloat, maxHeight: CGFloat, yOffset: CGFloat) -> CGFloat {
        // If scrolling up, yOffset will be a negative number
        if maxHeight + yOffset < minHeight {
            // SCROLLING UP
            // Never go smaller than our minimum height
            return minHeight
        }
        else if maxHeight + yOffset > maxHeight {
            // SCROLLING DOWN PAST MAX HEIGHT
            return maxHeight + (yOffset * 0.5) // Lessen the offset
        }

        // Return an offset that is between the min and max heights
        return maxHeight + yOffset
    }

    private func content(contact:Contact) -> some View {
        ScrollView {
            ZStack {
                VStack {
                    ContactTitleCellView(contact: contact)

                    contactDetails(contact: contact)

                    RelationshipsView(viewModel: viewModel.relationships )

                    ReminderListeView(viewModel: viewModel.reminderListViewModel)

                    PhotoCarrouselView(viewModel: viewModel.photoCarrouselViewModel)

                    ListNotesView(notes: $viewModel.note)

                    ActivitiesView(viewModel: .init(idContact: contact.id))

                }
                .padding(.top, 190)


                // Top Layer (Header)
                GeometryReader { gr in
                    VStack {
                        self.viewModel.adress
                            .map {
                                MapView(latitude: Double($0.latitude),
                                        longitude: Double($0.longitude))
                                    .frame(height: self.calculateHeight(minHeight: 75,
                                                                        maxHeight: 200,
                                                                        yOffset: gr.frame(in: .global).origin.y))
                                    .offset(y: gr.frame(in: .global).origin.y < 0
                                        ? abs(gr.frame(in: .global).origin.y)
                                        : -gr.frame(in: .global).origin.y)
                        }
                        Spacer()
                    }

                }
            }
        }
        .edgesIgnoringSafeArea(.vertical)
        .background(Color("GrayBackground"))
    }

    private func contactDetails(contact: Contact) -> some View {

        VStack(alignment: .leading) {
            HStack {
                Text("At a glance")
                    .foregroundColor(Color("Body"))
                    .font(.system(size: 20.0, weight: .regular, design: .rounded))
                Spacer()

                Text("Less")
                    .foregroundColor(Color("Link"))
                    .font(.SFUIDisplayFontRegularTwelve())
            }
            .padding(.top, spacing)
            .padding(.horizontal, spacing)

            HStack{
                Text("Born")
                    .foregroundColor(Color("Gray"))
                    .font(.SFUIDisplayFontRegularTwelve())

                Spacer()

                Text("Last activity together")
                    .foregroundColor(Color("Gray"))
                    .font(.SFUIDisplayFontRegularTwelve())
            }
            .padding(.horizontal, spacing)
            .padding(.top, spacing)

            HStack{
                Text(viewModel.bornText)
                    .foregroundColor(Color("Body"))
                    .font(.SFUIDisplayFontRegularSeventeen())

                Spacer()
                Text(viewModel.lastActivityDate)
                    .foregroundColor(Color("Body"))
                    .font(.SFUIDisplayFontRegularSeventeen())

            }
            .padding(.horizontal, spacing)
            .padding(.top, 5)

            ImageAndTextHorizontaleView(text: contact.addresses.first?.getCompleteAdress() ?? "",
                                        imageName: "map")
                .padding(.horizontal, spacing)

            ForEach(viewModel.contactFields, id: \.id) { contactField in
                ImageAndTextHorizontaleView(text: contactField.value,
                                            imageName: contactField.imageName)
                    .padding(.horizontal, self.spacing      )
            }
        }.background(Color.white)
    }
}

#if DEBUG
struct ContactDetailsView_Previews: PreviewProvider {
    @State static var show = false
    static var previews: some View {
        ContactDetailsView(viewModel: .init(id: 0))
    }
}
#endif
