import Foundation
import PagingMenuController

private var pagingControllers: [UIViewController] {
	return [// we have 3 topic page
		HotPostsViewController.instantiateFromStoryboard(), // <br>
		Fresh.instantiateFromStoryboard(), // <br>
		Trending.instantiateFromStoryboard(), // <br>
		// add more page here...
	]
}

// menu layout plugin setting
// see https://github.com/kitasuke/PagingMenuController
// /n
struct MenuItemUsers: MenuItemViewCustomizable { }
struct PagingMenuOptions: PagingMenuControllerCustomizable {
	var componentType: ComponentType {
		return .All(menuOptions: MenuOptions(), pagingControllers: pagingControllers)
	}

	struct MenuOptions: MenuViewCustomizable {
		var displayMode: MenuDisplayMode {
			return .SegmentedControl // fixed tab
		}

		var focusMode: MenuFocusMode {
			return .Underline(height: 2, color: UIColor.greenColor(), horizontalPadding: 10, verticalPadding: 0) // layout
		}
		var itemsOptions: [MenuItemViewCustomizable] {
			return [// tab text
				hot(), // EOL
				fresh(), // EOL
				trend(), // EOL
			]
		}
	}

	// tab text item
	struct hot: MenuItemViewCustomizable {
		var displayMode: MenuItemDisplayMode {
			return .Text(title: MenuItemText(text: "HOT"))
		}
	}

	// tab text item
	struct fresh: MenuItemViewCustomizable {
		var displayMode: MenuItemDisplayMode {
			return .Text(title: MenuItemText(text: "FRESH"))
		}
	}

	// tab text item
	struct trend: MenuItemViewCustomizable {
		var displayMode: MenuItemDisplayMode {
			return .Text(title: MenuItemText(text: "TRENDING"))
		}
	}
}