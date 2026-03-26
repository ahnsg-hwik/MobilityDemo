//
//  MainView.swift
//  Main
//
//  Created by iOS_Hwik on 12/16/25.
//

import SwiftUI

import ComposableArchitecture
import PopupView

import Domain
import DSKit

public struct MainView: View {
    @Perception.Bindable var store: StoreOf<MainFeature>
    
    @State private var isHidden = false
    private let visibleWidth: CGFloat = 20
    private let totalWidth: CGFloat = 80
    
    @State private var offset: CGFloat = 0

    public init(store: StoreOf<MainFeature>) {
        self.store = store
    }
    
    public var body: some View {
        WithPerceptionTracking {
            ZStack {
                NaverMap(store: store.scope(state: \.naverMap, action: \.naverMap))
                .onMapTap {
                    initSelectedMarker()
                }
                .ignoresSafeArea()
                
                VStack {
                    SearchArea
                        .padding(.top, 12)
                        .padding(.horizontal, 24)
                    
                    BubbleKeywordArea
                        .padding(.vertical, 4)

                    Spacer()
                    
                    ControllerArea
                        .padding(.horizontal, 24)
                        .padding(.vertical, 18)
                }
                
                floatingArea
            }
            .onAppear() {
                store.send(.onAppear)
            }
            .sheet(item: $store.scope(state: \.sheet, action: \.sheet)) {
                PhotoView(store: $0)
            }
            .popup(isPresented: $store.isMarkerPresented.sending(\.onMarkerTapped)) {
                if let data = store.selectedMarkerData as? Mobility {
                    MobilityBottomSheet(data: data) {
                        store.send(.onMarkerTapped(false))
                    }
                }
            } customize: {
                $0
                    .type(.floater(verticalPadding: 0, useSafeAreaInset: false))
                    .position(.bottom)
                    .dragToDismiss(false)
                    .closeOnTap(false)
            }
            .popup(isPresented: $store.isPopupPresented.sending(\.onPopupButtonTapped)) {
                BottomSheetFirst {
                    store.send(.onPopupButtonTapped(false))
                }
            } customize: {
                $0
                    .type(.floater(verticalPadding: 0, useSafeAreaInset: false))
                    .position(.bottom)
                    .dragToDismiss(false)
                    .closeOnTap(false)
                    .backgroundColor(.black.opacity(0.4))
                    .allowTapThroughBG(false)
            }
            .popup(isPresented: $store.isSheetPresented.sending(\.onSheetButtonTapped)) {
                ActionSheetFirst()
            } customize: {
                $0
                    .type(.toast)
                    .position(.bottom)
                    .closeOnTap(false)
                    .backgroundColor(.black.opacity(0.4))
                    .allowTapThroughBG(false)
            }
            .contentBackground(isPresented: $store.isMenuPresented.sending(\.onMenuButtonTapped)) {
                SideMenu { item in
                    print("item: \(item)")
                    store.send(.onMenuButtonTapped(false))
                    switch item {
                    case .setting:
                        store.send(.onTapSetting)
                    default:
                        break
                    }
                }
            } customize: {
                $0
                    .edgeTransition(.move(edge: .leading))
                    .backgroundColor(.black.opacity(0.4))
            }
        }
    }
    
    var floatingArea: some View {
        HStack {
            Spacer()
            
            HStack {
                Color.black
                    .opacity(0.2)
                    .frame(width: 8, height: 30)
                    .clipShape(Capsule())
                    .onTapGesture {
                        withAnimation(.spring(response: 0.4, dampingFraction: 0.7)) {
                            isHidden.toggle()
                        }
                    }
                
                VStack(spacing: 8) {
                    Image(systemName: "p.square.fill")
                        .font(.system(size: 30))
                        .foregroundColor(.white)
                        .padding(8)
                        .background(.blue)
                        .cornerRadius(8)
                        .onTapGesture {
                            store.send(.onPopupButtonTapped(true))
                        }
                    
                    Image(systemName: "s.square.fill")
                        .font(.system(size: 30))
                        .foregroundColor(.white)
                        .padding(8)
                        .background(.red)
                        .cornerRadius(8)
                        .onTapGesture {
                            store.send(.onSheetButtonTapped(true))
                        }
                }
            }
            .frame(width: totalWidth)
            .padding(.vertical, 10)
            .background(.white.opacity(0.5))
            .cornerRadius(8, corners: [.topLeft, .bottomLeft])
            .offset(x: isHidden ? (totalWidth - visibleWidth) : 0, y: -80)
        }
    }

    var SearchArea: some View {
        HStack(spacing: 8) {
            Text("목적지, 맛집/카페를 검색해 보세요.")
                .font(.system(size: 16))
                .foregroundColor(Color(.systemGray3))
                .padding(.horizontal, 14)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
                .background(Color.white)
                .clipShape(Capsule())
                .shadowRadius2()
            
            Image(systemName: "arrow.triangle.branch")
                .font(.system(size: 20, weight: .bold))
                .foregroundColor(.white)
                .frame(width: 48, height: 48)
                .background(Color(.representation(.mdSubColor)))
                .clipShape(Circle())
                .shadowRadius2()
        }
        .fixedSize(horizontal: false, vertical: true)
    }
    
    var BubbleKeywordArea: some View {
        ScrollView(.horizontal) {
            HStack {
                ForEach(BubbleKeywordKind.allCases, id: \.self) { keyword in
                    HStack(spacing: 8) {
                        Image(systemName: keyword.imageName)
                            .font(.system(size: 12, weight: .bold))
                            .foregroundColor(keyword.color)
                        
                        Text(keyword.name)
                            .font(.system(size: 12, weight: .regular))
                            .foregroundColor(.black)
                    }
                    .padding(.vertical, 8)
                    .padding(.horizontal, 12)
                    .background(Color.white)
                    .clipShape(Capsule())
                    .shadowRadius2()
                    .fixedSize(horizontal: true, vertical: false)
                    .onTapGesture {
                        initSelectedMarker()
                        store.send(.onChangeBubbleKeywordKind(keyword))
                    }
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal, 24)
            .padding(.bottom, 5)
        }
    }
    
    var ControllerArea: some View {
        HStack {
            CircleButton("location.circle.fill")
                .onTapGesture {
                    store.send(.onCurrentLocation)
                }
            
            Spacer()
            
            HStack(spacing: 8) {
                Image(systemName: "qrcode.viewfinder")
                    .font(.system(size: 24))
                    .foregroundColor(.white)
                
                Text("대여하기")
                    .font(.system(size: 18, weight: .bold))
                    .foregroundColor(.white)
            }
            .frame(width: 180, height: 60)
            .background(Color(.representation(.mdColor)))
            .clipShape(Capsule())
            .shadowRadius2()
            .onTapGesture {
                store.send(.sheetPresented)
            }
            
            Spacer()
            
            CircleButton("line.horizontal.3")
                .onTapGesture {
                    store.send(.onMenuButtonTapped(true))
                }
        }
    }
    
    func CircleButton(_ name: String) -> some View {
        Image(systemName: name)
            .font(.system(size: 18))
            .foregroundColor(Color.black)
            .frame(width: 40, height: 40)
            .background(Color.white)
            .clipShape(Circle())
            .shadowRadius2()
    }
}

extension MainView {
    func initSelectedMarker() {
        store.send(.naverMap(.onChangeSelectedMarkerData(nil)))
        store.send(.naverMap(.onMarkerTapped(false)))
    }
}

#Preview {
    MainView(
        store: Store(
            initialState: .init(),
            reducer: { MainFeature() }
        )
    )
}
