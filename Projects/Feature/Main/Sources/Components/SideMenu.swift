//
//  SideMenu.swift
//  Main
//
//  Created by iOS_Hwik on 12/17/25.
//

import SwiftUI

enum MenuItem: Int, CaseIterable {
    case signin = 0
    case history
    case payment
    case voucher
    case fare
    case notice
    case customer
    case setting
    
    var image: String {
        switch self {
        case .signin:
            return "faceid"
        case .history:
            return "list.bullet.clipboard"
        case .payment:
            return "creditcard"
        case .voucher:
            return "ticket"
        case .fare:
            return "text.document"
        case .notice:
            return "document"
        case .customer:
            return "person"
        case .setting:
            return "gearshape"
        }
    }
    
    var title: String {
        switch self {
        case .signin:
            return String(localized: "signin")
        case .history:
            return String(localized: "history")
        case .payment:
            return String(localized: "payment")
        case .voucher:
            return String(localized: "voucher")
        case .fare:
            return String(localized: "fare")
        case .notice:
            return String(localized: "notice")
        case .customer:
            return String(localized: "customer")
        case .setting:
            return String(localized: "settings")
        }
    }
}

struct SideMenu: View {
    /// Item Touch Event
    var onTouch: (MenuItem) -> Void
    
    /// HorizontalAlignment
    var alignment: HorizontalAlignment = .leading
    
    /// CGFloat
    var spacing: CGFloat? = 110
    
    var body: some View {
        HStack {
            if alignment == .trailing {
                Spacer()
            }
            
            ScrollView {
                LazyVStack(spacing: .zero) {
                    ForEach(MenuItem.allCases, id: \.self) { item in
                        SideMenuItem(item: item)
                            .onTapGesture {
                                onTouch(item)
                            }
                    }
                }
                .padding(.vertical, 16)
            }
            .frame(width: UIScreen.main.bounds.size.width - (spacing ?? .zero))
            .background(Color.white)

            if alignment == .leading {
                Spacer()
            }
        }
    }
}

struct SideMenuItem: View {
    var item: MenuItem
    
    var body: some View {
        HStack(spacing: 15) {
            Image(systemName: item.image)
                .font(.system(size: 20))
                .foregroundColor(.red)
                .frame(width: 25, height: 25)
            
            Text(item.title)
                .font(.system(size: 18))
                .foregroundColor(Color.black)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding()
    }
}

#Preview {
    SideMenu { print($0) }
}
