import UIKit

import FSCalendar
import SnapKit
import Then

final class HomeView: UIView {
    
    // MARK: - UI Components
    
    private(set) lazy var refreshControl = UIRefreshControl()
    lazy var homeCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout())
    var calendar = FSCalendar(frame: .zero)
    let addMissionButton = NotTodoButton(frame: CGRect(), mode: .withImage, text: I18N.addMissoinButton, image: .plus, font: .semiBold, size: 16)
    
    // MARK: - Life Cycle
    
    init(frame: CGRect, motivationText: String = "초기화값입니다.") {
        super.init(frame: frame)
        setUI()
        setLayout()
        register()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension HomeView {
    private func layout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionHeadersPinToVisibleBounds = true
        return layout
    }
    
    private func register() {
        homeCollectionView.register(HomeCollectionReusableView.self,
                                    forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                    withReuseIdentifier: HomeCollectionReusableView.identifier)
        homeCollectionView.register(HomeEmptyCollectionViewCell.self,
                                    forCellWithReuseIdentifier: HomeEmptyCollectionViewCell.identifier)
        homeCollectionView.register(HomeCalendarCollectionViewCell.self,
                                    forCellWithReuseIdentifier: HomeCalendarCollectionViewCell.identifier)
        homeCollectionView.register(HomeMissionCollectionViewCell.self,
                                    forCellWithReuseIdentifier: HomeMissionCollectionViewCell.identifier)
    }
    
    private func setUI() {
        backgroundColor = .white
        homeCollectionView.do {
            $0.backgroundColor = .BG
            $0.refreshControl = refreshControl
            $0.refreshControl?.addTarget(self, action: #selector(handleRefreshControl),
                                         for: .valueChanged)
        }
    }
    
    @objc func handleRefreshControl() {
        // 컨텐츠를 업데이트하세요.
        homeCollectionView.reloadData()
        
        // Refresh control을 제거하세요.
        DispatchQueue.main.async {
            self.homeCollectionView.refreshControl?.endRefreshing()
        }
    }
    
    private func setLayout() {
        addSubviews(homeCollectionView, addMissionButton)
        
        homeCollectionView.snp.makeConstraints {
            $0.top.leading.trailing.equalTo(safeAreaLayoutGuide)
            $0.bottom.equalToSuperview().inset(62.adjusted)
        }
        
        addMissionButton.snp.makeConstraints {
            $0.width.equalTo(149.adjusted)
            $0.height.equalTo(46.adjusted)
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(safeAreaLayoutGuide).inset(9.adjusted)
        }
    }
}
