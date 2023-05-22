//
//  DesignTime+BackDeploy.swift
//  PreviewViewLegacyOSCompileFix
//
//  Created by Josh Asbury on 22/5/2023.
//

@backDeployed(before: iOS 13)
public func __designTimeString(_ value: String, fallback: String) -> String {
    fallback
}

@backDeployed(before: iOS 13)
public func __designTimeFloat(_: String, fallback: Float) -> Float {
    fallback
}

@backDeployed(before: iOS 13)
public func __designTimeBoolean(_: String, fallback: Bool) -> Bool {
    fallback
}

@backDeployed(before: iOS 13)
public func __designTimeInteger(_: String, fallback: Int) -> Int {
    fallback
}
