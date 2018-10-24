# MJHeaderViewHideShow

[![License: MIT](https://img.shields.io/badge/license-MIT-blue.svg?style=flat)](https://github.com/kagmanoj25/TopHeaderViewHideShow/blob/master/LICENSE)
[![Issues](https://img.shields.io/github/issues/kagmanoj25/TopHeaderViewHideShow.svg)](https://github.com/kagmanoj25/TopHeaderViewHideShow/issues)
[![Forks](https://img.shields.io/github/forks/kagmanoj25/TopHeaderViewHideShow.svg)](https://github.com/kagmanoj25/TopHeaderViewHideShow)
[![Stars](https://img.shields.io/github/stars/kagmanoj25/TopHeaderViewHideShow.svg)](https://github.com/kagmanoj25/TopHeaderViewHideShow)
[![Language](https://img.shields.io/badge/Language-Swift-yellow.svg)](https://github.com/kagmanoj25/TopHeaderViewHideShow)

## Preview
Scroll to hide/show custom header view using `TableView OR ScrollView`.<br />   <br />

<p align="center">
    <img src="https://github.com/kagmanoj25/TopHeaderViewHideShow/blob/master/Gif(s)/scroll_1.gif" width="300">
</p>

## Requirements
- Xcode 9.0+
- iOS 10+
- Swift 4.0+

## Installation
## Usage

MJHeaderViewHideShow will be used via interface builder.

* Add Custom View `(UIView)` at the top in your interface builder. Add `MJHeaderAnimation` in `Class` property at Identity Inspector of added view.

* You've to add `Height` constraint to your Custom View, don't add identifier to it, library will detect height automatically.
  
#### Properties
Use following properties to edit it's default functionality. Add your settings in `viewDidLoad`.

```swift 
// declare instance of KJNavigationViewAnimation by connecting it to UIView outlet in interface builder
@IBOutlet weak var viewTop: MJHeaderAnimation!
```
    
```swift 
override func viewDidLoad() {
    super.viewDidLoad()
    // Hide default NavigationBar
    self.navigationController?.isNavigationBarHidden = true
    //Parameter details
    // 1. UITableView instance
    // 2. Title Optional with ""
    // 3. Minimum header view hieght
    self.viewTop.initializationTopViewSettings(self.tblView, "Manoj", 44)
}
```
#### Methods
You have to extend your `viewController` class with `UIScrollViewDelegate`, and connect `TableView delegate to self`. Last step to call `MJHeaderAnimation scrollview methods` as below from `UIScrollViewDelegate delegate methods`

```Swift
extension ViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
       // MJHeaderView is my declared MJHeaderViewHideShow property in ViewController class
        viewTop.scrollViewDidScroll(scrollView)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        viewTop.scrollViewDidEndDecelerating(scrollView)
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        viewTop.scrollViewDidEndDragging(scrollView, willDecelerate: decelerate)
    }
}
```
## Author
### Manoj Kag
- [Facebook](https://www.facebook.com/profile.php?id=100000647370380)
- [GitHub](https://github.com/kagmanoj25)

## License
`TopHeaderViewHideShow` is available under the MIT license. See the [LICENSE](./LICENSE) file for more info.
