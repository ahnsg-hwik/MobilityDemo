//
//  PhotoView.swift
//  Main
//
//  Created by iOS_Hwik on 12/26/25.
//

import SwiftUI

import ComposableArchitecture
import Kingfisher

public struct PhotoView: View {
    var store: StoreOf<PhotoFeature>
    
    public init(store: StoreOf<PhotoFeature>) {
        self.store = store
    }

    public var body: some View {
        VStack {
            List {
                ForEach(store.photoList, id: \.id) { item in
                    HStack(spacing: 16) {
                        KFImage(URL(string: item.download_url)!)
                            .placeholder { Image(systemName: "photo.on.rectangle.angled.fill") }
                            .fade(duration: 0.3)
                            .setProcessor(DownsamplingImageProcessor(size: CGSize(width: 45, height: 45))) // 이미지 다운샘플링 (용량 큰 이미지는 캐싱을 위한 내부 저장 시 지연 발생)
                            .cacheOriginalImage() // 원본 이미지를 캐시할지 선택
                            .resizable()
                            .frame(width: 40, height: 40)
                            .clipShape(Capsule())
                        
                        Text(item.author)
                    }
                    .listRowSeparator(.hidden)
                }
            }
            .listStyle(.plain)
            .padding(.top, 24)
            
            Text("종료하기")
                .font(.system(size: 18, weight: .bold))
                .foregroundColor(.white)
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.pink)
                .clipShape(Capsule())
                .shadowRadius2()
                .padding()
                .onTapGesture {
                    store.send(.closeButtonTapped)
                }
        }
        .onAppear() {
            store.send(.onAppear)
        }
    }
}

#Preview {
    PhotoView(
        store: Store(initialState: PhotoFeature.State()) {
            PhotoFeature().body._printChanges()
        }
    )
}
