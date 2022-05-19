import UIKit

class TableViewCell: UITableViewCell {
	// linking the storyboard
	@IBOutlet weak var collectionView: UICollectionView!
	@IBOutlet weak var label: UILabel!
	@IBOutlet weak var iView: UIImageView!
}

extension TableViewCell {
	func setCollectionViewDataSourceDelegate<D: protocol<UICollectionViewDataSource, UICollectionViewDelegate>>(dataSourceDelegate: D, forRow row: Int) {
		collectionView.delegate = dataSourceDelegate// collection view delegate
		collectionView.dataSource = dataSourceDelegate//
		collectionView.tag = row // name it with index
		collectionView.setContentOffset(collectionView.contentOffset, animated: false) // Stops collection view if it was scrolling.
		collectionView.reloadData() // reload
	}
}
