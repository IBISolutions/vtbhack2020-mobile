//
//  InfiniteContainer.swift
//  VTBUI
//
//  Created by viktor.volkov on 10.10.2020.
//

import UIKit
import SnapKit

public final class InfiniteContainer: CustomView {

    private(set) public var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.delaysContentTouches = false
        return scrollView
    }()

    public let innerContainer = UIStackView()
    private var components = [UIView]()

    override public init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override public func configure() {
        super.configure()
        
        backgroundColor = .clear
        innerContainer.backgroundColor = .clear

        innerContainer.axis = .vertical
        innerContainer.alignment = .fill
        innerContainer.distribution = .fill
        innerContainer.spacing = 0
        
        addSubview(scrollView)
        scrollView.snp.makeConstraints { $0.edges.equalToSuperview() }
        
        scrollView.addSubview(innerContainer)
        innerContainer.snp.makeConstraints {
            make in
            
            make.leading.trailing.top.width.equalToSuperview()
            make.height.bottom.equalToSuperview().priority(.high)
        }
    }
    
    public func setComponentsWithoutEdges(_ components: [UIView]) {
        let mappedComponents: [(UIView, UIEdgeInsets)] = components.map { ($0, .zero) }
        setComponents(mappedComponents)
    }

    public func setComponents(_ components: [(UIView, UIEdgeInsets)]) {
        innerContainer.subviews.forEach {
            $0.removeFromSuperview()
        }

        self.components.removeAll()

        components.forEach {
            view, insets in
            
            let v = wrap(view, with: insets)
            v.isHidden = view.isHidden
            v.setRequiredContentHuggingPriority(.vertical)
            v.setRequiredCompressionResistancePriority(.vertical)
            innerContainer.addArrangedSubview(v)
            self.components.append(view)
        }
    }
    
    public func addComponent(_ component: UIView, with insets: UIEdgeInsets = .zero) {
        let v = wrap(component, with: insets)
        v.setRequiredContentHuggingPriority(.vertical)
        v.setRequiredCompressionResistancePriority(.vertical)
        innerContainer.addArrangedSubview(v)
        self.components.append(component)
    }

    public func insert(_ component: UIView, at index: Int, with insets: UIEdgeInsets = .zero) {
        let v = wrap(component, with: insets)
        innerContainer.insertArrangedSubview(v, at: index)
        components.insert(component, at: index)
    }

    public func insert(_ newComponent: UIView, before component: UIView, with insets: UIEdgeInsets = .zero) {
        if let index = components.firstIndex(of: component) {
            insert(newComponent, at: index, with: insets)
        }
    }

    public func remove(_ component: UIView) {
        if let index = components.firstIndex(of: component) {
            component.superview?.removeFromSuperview()
            component.removeFromSuperview()
            components.remove(at: index)
        }
    }
    
    public func setComponent(_ component: UIView, isHidden: Bool) {
        component.isHidden = isHidden
        component.superview?.isHidden = isHidden
    }

    public func removeAll() {
        components.forEach { $0.removeFromSuperview() }
        components.removeAll()
        innerContainer.arrangedSubviews.forEach { $0.removeFromSuperview() }
    }
}

private extension InfiniteContainer {

    func wrap(_ component: UIView, with insets: UIEdgeInsets) -> UIView {
        let v = UIView()
        v.addSubview(component)
        component.snp.makeConstraints { $0.edges.equalToSuperview().inset(insets) }
        return v
    }
}
