//
//  ClusteringClient.swift
//  Feature
//
//  Created by iOS_Hwik on 1/16/26.
//

import Foundation
import ComposableArchitecture

@DependencyClient
public struct ClusteringClient: Sendable {
    public var updateClustering: @Sendable (Int, BubbleKeywordKind) -> Bool = { _, _ in false }
    public var updateNextTime: @Sendable (String, Int) -> Void
}

extension DependencyValues {
    public var mainClient: ClusteringClient {
        get { self[ClusteringKeyClient.self] }
        set { self[ClusteringKeyClient.self] = newValue }
    }
}

private enum ClusteringKeyClient: DependencyKey {
    public static var liveValue: ClusteringClient = {
        let fmsService = FMSService()
        
        return ClusteringClient(
            updateClustering: { level, type in
                fmsService.updateClustering(for: level, type: type)
            }, updateNextTime: { nextTimeDiff, level in
                fmsService.updateNextTime(nextTimeDiff, level: level)
            }
        )
    }()
    
    public static var previewValue: ClusteringClient = {
        let fmsService = FMSService()
        
        return ClusteringClient(
            updateClustering: { level, type in
                fmsService.updateClustering(for: level, type: type)
            }, updateNextTime: { nextTimeDiff, level in
                fmsService.updateNextTime(nextTimeDiff, level: level)
            }
        )
    }()
}

extension ClusteringKeyClient {
    private class FMSService {
        private var keyword: BubbleKeywordKind?
        
        private var markerLevel1UpdateTime = Date()
        private var markerLevel2UpdateTime = Date()
        
        func updateClustering(for level: Int, type: BubbleKeywordKind) -> Bool {
            if updateBubbleKeywordKind(to: type) {
                markerLevel1UpdateTime = Date()
                markerLevel2UpdateTime = Date()
                return true
            }
            
            return checkClusteringUpdate(for: level)
        }
        
        func checkClusteringUpdate(for level: Int) -> Bool {
            let nowTime: Date = Date()
            
            if level == 1 {
                return nowTime < markerLevel1UpdateTime ? false : true
            } else {
                return nowTime < markerLevel2UpdateTime ? false : true
            }
        }
        
        func updateNextTime(_ nextTimeDiff: String, level: Int) {
            if level == 1 {
                markerLevel1UpdateTime = nextTimeDiff.nextTime()
            } else {
                markerLevel2UpdateTime = nextTimeDiff.nextTime()
            }
        }
        
        private func updateBubbleKeywordKind(to type: BubbleKeywordKind) -> Bool {
            guard self.keyword != type else { return false }
            self.keyword = type
            return true
        }
    }
}

extension String {
    /// "yyyy-MM-dd HH:mm:ss" 날짜 시간 문자열을 Date로 반환
    /// - Returns: 업데이트 시간
    public func nextTime() -> Date {
        let times = self.components(separatedBy: ":").reversed()
        var nextTime: Int = 0
        for (index, stringTime) in times.enumerated() {
            if let time = Int(stringTime) {
                nextTime += time * Int(pow(60.0, Double(index)))
            }
        }
        return Date(timeIntervalSinceNow: TimeInterval(nextTime))
    }
}
