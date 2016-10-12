
import UIKit
import SnapKit

enum ControllerStatus{
    case Full
    case Small
}

class MainViewController: UIViewController{
    
    
    private var vcStatus: ControllerStatus = .Full
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.blackColor()
        UIApplication.sharedApplication().setStatusBarHidden(true, withAnimation: .None)
        setUpRootViewControllers()
        
        self.view.addSubview(menuController.view)
        self.view.addSubview(self.scrollView)
        self.view.addSubview(self.mainHeaderView)
        self.view.addSubview(self.redLineView)
        self.view.addSubview(self.menuButton)
        self.view.addSubview(self.classifyButton)
        
        setupBtnConstraints()
    }
    
    private func setupBtnConstraints(){
        self.menuButton.snp_makeConstraints { (make) in
            make.right.equalTo(-15)
            make.top.equalTo(35)
            make.width.height.equalTo(45)
        }
        self.classifyButton.snp_makeConstraints { (make) in
            make.left.equalTo(15)
            make.top.equalTo(35)
            make.width.height.equalTo(45)
        }
    }
    
    private lazy var mainHeaderView: MainHeaderView = {
        let headerView = MainHeaderView(frame: CGRect(x: 0, y: 0, width: self.scrollView.contentSize.width, height: 20))
        return headerView
    }()
    
    private lazy var redLineView:UIView = {
        let line = UIView()
        line.frame = CGRect(x: self.view.center.x - 20, y: 0, width: 40, height: 1)
        line.backgroundColor = UIConstant.UI_COLOR_RedTheme
        return line
        
    }()
    
    private lazy var classifyButton: UIButton = {
        let button = UIButton()
        let img = UIImage(imageLiteral: "ic_circle")
        button.setImage(img, forState: .Normal)
        button.addTarget(self, action: #selector(MainViewController.classifyBtnClicked), forControlEvents: .TouchUpInside)
        return button
    }()
    
    
    /*
     菜单按钮
    */
    private lazy var menuButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(imageLiteral:"ic_hamburg"), forState: .Normal)
        button.addTarget(self, action: #selector(MainViewController.menuBtnClicked(_:)), forControlEvents: .TouchUpInside)
        return button
    }()
   
    
    override func prefersStatusBarHidden() -> Bool {
        return statusBarHidden
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return statusBarStyle
    }
    
    override func preferredStatusBarUpdateAnimation() -> UIStatusBarAnimation {
        return .Slide
    }
    
    private var statusBarStyle: UIStatusBarStyle = .LightContent
    
    private var statusBarHidden = true
    
    func setUpRootViewControllers(){
        menuController.view.frame = self.view.bounds
        
        self.addChildViewController(menuController)
        
        self.addChildViewController(newsFlashController)
        self.addChildViewController(homeController)
        self.addChildViewController(playingzhiController)
        self.addChildViewController(appsoController)
        self.addChildViewController(mindStoreController)
        viewArray.append(newsFlashController.view)
        viewArray.append(homeController.view)
        viewArray.append(playingzhiController.view)
        viewArray.append(appsoController.view)
        viewArray.append(mindStoreController.view)
        
        for i in 0..<viewArray.count{
            let view = viewArray[i]
            view.frame = CGRect(x: self.view.width*CGFloat(i), y: 0, width: self.scrollView.width, height: self.scrollView.height)
            self.scrollView.addSubview(view)
        }
        self.scrollView.contentSize = CGSize(width: self.scrollView.width*CGFloat(viewArray.count), height: self.scrollView.height)
        self.scrollView.setContentOffset(CGPoint(x: scrollView.width, y: 0), animated: false)
    }
    
    let menuController = MenuViewController()
    
    let newsFlashController = NewsFlashViewController()
    let homeController = HomeViewController()
    let playingzhiController = PlayingzhiViewController()
    let appsoController = AppsoViewController()
    let mindStoreController = MindStoreViewController()
    
    private var viewArray = [UIView]()
    
    private let scale: CGFloat = 0.4

    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView(frame: CGRect(x: 0, y: UIConstant.UI_MARGIN_20, width: self.view.width, height: self.view.height - UIConstant.UI_MARGIN_20))
        scrollView.pagingEnabled = true
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.delegate = self
        return scrollView
    }()
    
    private var coverBtnArray: [UIButton] = []
    
    
    private func createCoverBtn() -> UIButton{
        let button = UIButton()
        button.backgroundColor = UIColor.blackColor().colorWithAlphaComponent(0.02)
        button.addTarget(self, action: #selector(MainViewController.menuBtnClicked(_:)), forControlEvents: .TouchUpInside)
        return button
    }

    
}



extension MainViewController{
    
    private func removeCategoryView(categoryView: CategoryView){
        UIView.animateWithDuration(0.5, animations: { 
            categoryView.alpha = 0
            self.mainHeaderView.alpha = 1
            }) { (com) in
                categoryView.removeFromSuperview()
        }
    }
    
    @objc private func classifyBtnClicked(){
        
        let categoryView = CategoryView(frame: CGRect(x: 0, y: 0, width: self.view.width, height: self.view.height))
        categoryView.alpha = 0
        self.view.addSubview(categoryView)
        UIView.animateWithDuration(0.5) { 
            categoryView.alpha = 1
            self.mainHeaderView.alpha = 0
        }
        
        categoryView.coverBtnClick { [unowned self] in
            self.removeCategoryView(categoryView)
        }
        
        categoryView.itemBtnDidClick {[unowned self] (collectionView, indexPath) in
            self.removeCategoryView(categoryView)
            if indexPath.row == 0{
                return
            }
            self.navigationController?.pushViewController(CategoryController(categoryModel: categoryModelArray[indexPath.row]), animated: true)
        }
    }
    
    @objc private func menuBtnClicked(view: UIView){
        
        setupCornerRadius()
        
        setupViewAnimation(view.tag)
        
    }
    
    private func setupCornerRadius(){
       
        UIView.animateWithDuration(0.5, animations: {[unowned self] in
            
            self.viewArray.forEach{
                let maskPath = UIBezierPath(roundedRect: $0.bounds, cornerRadius: self.vcStatus == .Small ? 0:20)
                let maskLayer = CAShapeLayer()
                maskLayer.frame = $0.bounds
                maskLayer.path = maskPath.CGPath
                $0.layer.mask = maskLayer
                
            }
        })
    }
    
    /**
     执行放大收缩动画前需要隐藏和显示一些控件
     */
    private func setupViewHidden(tag: Int = 0) {
        
        // 设置状态栏
        statusBarHidden = vcStatus == .Small ?true:false
        setNeedsStatusBarAppearanceUpdate()
        // 设置菜单分类按钮,下拉刷新
        self.mainHeaderView.hidden = vcStatus == .Small ?false:true
        self.redLineView.hidden = vcStatus == .Small ?false:true
        if tag == 1 {
            self.classifyButton.alpha = 1
            self.classifyButton.hidden = vcStatus == .Small ?false:true
        } else {
            self.classifyButton.hidden = true
        }
        self.menuButton.hidden = vcStatus == .Small ?false:true
    }

    private func setupViewAnimation(tag: Int = 0){
        let scaleWidth = vcStatus == .Small ? scrollView.width:scrollView.width * scale
        let transY = vcStatus == .Small ?self.view.center.y+UIConstant.UI_MARGIN_10:scrollView.center.y+scrollView.height*(1-scale)*0.5
        let scrollViewTransCenter = CGPoint(x: self.scrollView.center.x, y: transY)
        // contentsize
        let contentSize = vcStatus == .Small ?CGSize(width: self.view.width*CGFloat(viewArray.count), height: 0):CGSize(width: (scaleWidth+UIConstant.UI_MARGIN_5)*CGFloat(self.viewArray.count), height: 0)
        // transform
        let scrollviewtransform = vcStatus == .Small ? CGAffineTransformIdentity:CGAffineTransformMakeScale(1, self.scale)
        let scrollsubviewTransform = vcStatus == .Small ?CGAffineTransformIdentity:CGAffineTransformMakeScale(self.scale, 1)
        // 获取点击后scrollview的contentoffset位置
        let index = vcStatus == .Small ?tag:Int(scrollView.contentOffset.x/self.view.width)
        var contentOffx = vcStatus == .Small ?CGFloat(index)*self.view.width:0.5*UIConstant.UI_MARGIN_5+CGFloat(index)*(scaleWidth+UIConstant.UI_MARGIN_5)
        contentOffx = contentOffx > contentSize.width-self.view.width ?contentSize.width-self.view.width:contentOffx
        // 设置头部空间位移差
        if vcStatus == .Small {
            let headerViewScale = self.view.width/(self.view.width*0.5-mainHeaderView.labelArray.last!.width*0.5)
            mainHeaderView.x = -contentOffx/headerViewScale
            
            
        }
        UIView.animateWithDuration(0.5, delay: 0, options: .CurveEaseOut, animations: { 
            [unowned self] in
            self.scrollView.center = scrollViewTransCenter
            self.scrollView.transform = scrollviewtransform
            self.scrollView.contentSize = contentSize
            
            self.scrollView.setContentOffset(CGPoint(x: contentOffx,y: 0), animated: false)
            self.setupViewHidden(tag)
            // 设置srollview子控件的动画
            for i in 0..<self.viewArray.count {
                let view = self.viewArray[i]
                
                view.transform = scrollsubviewTransform
                let centerX = self.vcStatus == .Small ? scaleWidth*(CGFloat(i)+0.5):(scaleWidth+UIConstant.UI_MARGIN_5)*(CGFloat(i)+0.5)
                view.center = CGPoint(x: centerX, y: view.center.y)
            }

            }) { (result) in
                if result{
                    
                    if self.vcStatus == .Small{
                        self.coverBtnArray.forEach{
                            $0.removeFromSuperview()
                        }
                    }else{
                        for i in 0..<self.viewArray.count{
                            let view = self.viewArray[i]
                            let coverBtn = self.createCoverBtn()
                            coverBtn.frame = view.bounds
                            coverBtn.tag = i
                            self.coverBtnArray.append(coverBtn)
                            view.addSubview(coverBtn)
                        }
                    }
                    
                    // 设置scrollview
                    self.scrollView.pagingEnabled = self.vcStatus == .Small ?true:false
                    
                    self.vcStatus = self.vcStatus == .Full ?.Small:.Full
                    
                }
        }
        
    }
    
    
}



extension MainViewController: UIScrollViewDelegate{
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        if vcStatus == .Full{
            let contentOffsetX = scrollView.contentOffset.x
            let alpha = 1 - fabs((contentOffsetX-UIConstant.SCREEN_WIDTH) / UIConstant.SCREEN_WIDTH)
            classifyButton.hidden = alpha <= 0 ?true: false
            classifyButton.alpha = alpha
            // 设置头部空间位移差
            let scale = self.view.width/(self.view.width*0.5-mainHeaderView.labelArray.last!.width*0.5)
            mainHeaderView.x = -scrollView.contentOffset.x/scale
        }
    }
    
}

extension MainViewController: ScrollViewControllerReusableDataSource{
    
    func titleHead() -> MainHeaderView {
        return self.mainHeaderView
    }
    
    func menuBtn() -> UIButton {
        return self.menuButton
    }
    
    func classifyBtn() -> UIButton {
        return self.classifyButton
    }
    
    func readLine() -> UIView {
        return self.redLineView
    }
    
}


extension MainViewController: ScrollViewControllerReusableDelegate{
    
    func scrollViewControllerDirectionDidChange(direction: ScrollviewDirection) {
        menuBtnAnimation(direction)
    }
    
    private func menuBtnAnimation(dir: ScrollviewDirection){
        let positionAnimation = CABasicAnimation(keyPath: "position.y")
        positionAnimation.fromValue = (dir == ScrollviewDirection.Down ?  classifyButton.y : -classifyButton.height )
        positionAnimation.toValue = (dir == ScrollviewDirection.Down ?(-classifyButton.height):classifyButton.y+20)
        
        let alphaAnim = CABasicAnimation(keyPath: "alpha")
        alphaAnim.fromValue = (dir == ScrollviewDirection.Down ?1:0)
        alphaAnim.toValue = (dir == ScrollviewDirection.Down ?0:1)
        
        let group = CAAnimationGroup()
        group.removedOnCompletion = false
        group.fillMode = kCAFillModeForwards
        group.animations = [positionAnimation, alphaAnim]
        group.duration = 0.2
        
        classifyButton.layer.addAnimation(group, forKey: "circleButtonDownAnimation")
        menuButton.layer.addAnimation(group, forKey: "hamburgButtonAnimation")
    }
    
}






