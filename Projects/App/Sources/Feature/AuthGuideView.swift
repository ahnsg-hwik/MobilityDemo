//
//  AuthGuideView.swift
//  MobilityDemo
//
//  Created by iOS_Hwik on 1/29/26.
//

import SwiftUI
import ComposableArchitecture
import PopupView

import DSKit

public struct AuthGuideItem {
    var required: Bool
    var imageName: String
    var title: String
    var content: String
}

public struct AuthGuideView: View {
    @Bindable var store: StoreOf<AuthGuideFeature>
    
    private var item: [AuthGuideItem] = [
        AuthGuideItem(required: true, imageName: "location", title: "위치 (필수)", content: "현위치 기반 주변겸색 등을 위한 접근 설정"),
        AuthGuideItem(required: true, imageName: "wifi", title: "블루투스 (필수)", content: "킥보드, 전기 자전거 대여를 위해 사용"),
        AuthGuideItem(required: true, imageName: "camera", title: "카메라 (필수)", content: "기기 QR코드 인식 및 사진 촬영을 위한 접근 설정")
    ]
    
    public init(store: StoreOf<AuthGuideFeature>) {
        self.store = store
    }
    
    public var body: some View {
        VStack {
            
            Spacer()
            
            ScrollView {
                VStack(alignment: .leading) {
                    HighlightText("편리한 이용을 위해\n접근권한의 허용이 필요 합니다.")
                        .base(font: .boldSystemFont(ofSize: 24))
                        .highlightText("접근권한의 허용")
                        .highlight(color: UIColor(Color(.representation(.mdColor))))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.top, 34)
                    
                    Text("필수 접근 권한")
                        .font(.title3)
                        .padding(.vertical)
                    
                    VStack {
                        ForEach(item, id: \.title) { item in
                            HStack(alignment: .top, spacing: 9) {
                                Image(systemName: item.imageName)
                                    .foregroundColor(Color(.representation(.mdColor)))
                                
                                VStack(spacing: 4) {
                                    HighlightText(item.title)
                                        .base(font: .boldSystemFont(ofSize: 18))
                                        .highlightText("(필수)")
                                        .highlight(font: .systemFont(ofSize: 18), color: UIColor(Color(.representation(.mdSubColor))))
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                    
                                    Text(item.content)
                                        .font(.system(size: 14))
                                        .foregroundColor(.gray)
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                }
                            }
                            .padding(.bottom, 16)
                        }
                    }
                    .padding(.horizontal, 14)
                }
            }
            
            Button(action: {
                store.send(.openSettingsButtonTapped(true))
            }) {
                Text("설정 하기")
                    .font(.system(size: 18, weight: .bold))
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color(.representation(.mdSubColor)))
                    .cornerRadius(8)
            }
        }
        .popup(isPresented: $store.isSettingPresented) {
            AuthGuideAlert {
                store.send(.openSettingsButtonTapped(false))
                store.send(.openSettings)
            }
        } customize: {
            $0
                .type(.floater())
                .appearFrom(.none)
                .disappearTo(.none)
                .position(.center)
                .closeOnTap(false)
                .allowTapThroughBG(false)
                .backgroundColor(.black.opacity(0.4))
        }
        .padding(.horizontal, 24)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.white)
        .onAppear() {
            store.send(.onAppear)
        }
    }
}

#Preview {
    AuthGuideView(
        store: Store(
            initialState: .init(),
            reducer: { AuthGuideFeature() }
        )
    )
}

public struct AuthGuideAlert: View {
    var onTap: () -> Void
    
    public var body: some View {
        VStack(spacing: 20) {
            VStack(alignment: .leading, spacing: 10) {
                Text("앱을 이용 하실려면 필수 권한을 허용해 주세요.")
                    .foregroundColor(.black)
                    .font(.system(size: 18, weight: .bold))
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                Text("기기의 '설정 > 앱'에서 설정 가능 합니다.")
                    .foregroundColor(.black)
                    .font(.system(size: 16))
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            
            Button(action: {
                onTap()
            }) {
                Text("설정 이동")
                    .font(.system(size: 18, weight: .bold))
                    .padding()
                    .frame(maxWidth: .infinity)
                    .foregroundColor(.white)
                    .background(Color(.representation(.mdSubColor)))
                    .cornerRadius(12)
            }
        }
        .padding(.vertical, 25)
        .padding(.horizontal, 24)
        .background(Color.white.cornerRadius(20))
        .padding(.horizontal, 16)
    }
}

#Preview {
    ZStack {
        Rectangle()
            .ignoresSafeArea()
        
        AuthGuideAlert { }
    }
}
