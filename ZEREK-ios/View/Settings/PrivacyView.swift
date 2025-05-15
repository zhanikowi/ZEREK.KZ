//
//  PrivacyView.swift
//  ZEREK
//
//  Created by bakebrlk on 23.04.2025.
//

import SwiftUI

struct PrivacyView: View {
    @EnvironmentObject var navigation: Navigation
    
    private var backgroundRectangle: some View {
        VStack {
            Rectangle()
                .frame(maxWidth: .infinity, maxHeight: UIScreen.main.bounds.height / 7.4)
                .foregroundColor(Constant.purple)
                .cornerRadius(Constant.radius)
            Spacer()
        }
    }
    
    private var topBar: some View {
        HStack {
            Button {
                navigation.navigateBack()
            } label: {
                Image(systemName: "chevron.left")
                    .configure
                    .frame(maxWidth: Constant.radius, maxHeight: Constant.radius)
            }
            
            Spacer()
            Constant.getText(text: "Privacy policy", font: .bold, size: 22)
                .frame(maxWidth: .infinity)
                .padding(.trailing, Constant.radius)
        }
        .foregroundColor(.white)
        .padding(.horizontal, Constant.radius)
        .padding(.top, Constant.radius * 3)
    }
    
    var body: some View {
        ZStack {
            backgroundRectangle
            
            VStack {
                topBar
                
                ScrollView(showsIndicators: false) {
                    Text( """
                       Welcome to Zerek! Your privacy is important to us. This Privacy Policy explains how we collect, use, and protect your personal information when you use our app.
                       1. Information We Collect When you use Zerek, we may collect the following types of information:
                       Personal Information: If you create an account, we may collect your name, email address, and profile details.
                       Usage Data: We collect data on how you interact with the app, such as lesson progress, preferences, and time spent on activities.
                       Device Information: We may collect information about your device, including its model, operating system, and IP address.
                       2. How We Use Your Information We use the collected information to:
                       Provide and improve Zerek’s language learning experience.
                       Personalize lessons and content based on your progress.
                       Analyze app usage to enhance features and usability.
                       Communicate with you about updates and support.
                       3. Sharing Your Information We do not sell or rent your personal data. However, we may share information with:
                       Service Providers: Trusted third parties that help us operate our app (e.g., cloud storage, analytics).
                       Legal Authorities: If required by law or to protect our rights and users.
                       4. Data Security We implement appropriate security measures to protect your data. However, no method of data transmission or storage is 100% secure.
                       5. Your Rights and Choices
                       You can access, update, or delete your personal data through your account settings.
                       You may opt out of certain data collection by adjusting your device settings.
                       If you wish to delete your account permanently, please contact us.
                       6. Changes to This Policy We may update this Privacy Policy from time to time. Any changes will be posted in the app with an updated effective date.
                       7. Contact Us If you have any questions about this Privacy Policy, please contact us at: [Insert Contact Email]
                    """)
                }
                .padding(.top, Constant.radius * 2)
                .padding(.horizontal, Constant.radius)
                .padding(.bottom, Constant.radius)
            }
        }
        .ignoresSafeArea()
    }
}

#Preview {
    PrivacyView()
}
