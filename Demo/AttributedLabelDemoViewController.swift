//
//  Created by Pavel Sharanda on 02.03.17.
//  Copyright © 2017 Pavel Sharanda. All rights reserved.
//

import UIKit
import Atributika

class AttributedLabelDemoViewController: UIViewController {
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: CGRect(), style: .plain)
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 50
        return tableView
    }()
    
    private var tweets: [String] = [
        "@e2F If only Bradley's arm was longer. Best photo ever. 😊 #oscars https://pic.twitter.com/C9U5NOtGap<br>Check this <a href=\"https://github.com/psharanda/Atributika\">link</a>",
        "For every retweet this gets, Pedigree will donate one bowl of dog food to dogs in need! 😊 #tweetforbowls",
        "All the love as always. H",
        "We got kicked out of a @Delta airplane because I spoke Arabic to my mom on the phone and with my friend slim... WTFFFFFFFF please spread",
        "Thank you for everything. My last ask is the same as my first. I'm asking you to believe—not in my ability to create change, but in yours.",
        "Four more years.",
        "RT or tweet #camilahammersledge for a follow 👽",
        "Denny JA: Dengan RT ini, anda ikut memenangkan Jokowi-JK. Pilih pemimpin yg bisa dipercaya (Jokowi) dan pengalaman (JK). #DJoJK",
        "Always in my heart @Harry_Styles . Yours sincerely, Louis",
        "HELP ME PLEASE. A MAN NEEDS HIS NUGGS https://pbs.twimg.com/media/C8sk8QlUwAAR3qI.jpg",
        "asdasdasdasdasdasd <i>lorem ipsum</i><b>lorem ipsum</b><p>lorem ipsum</p><b>lorem ipsum</b><p>lorem ipsum</p><br /><i>lorem ipsum</i><p>lorem ipsum</p><br /><br /><br /><br /><p>lorem ipsum</p><b>lorem ipsum</b><br /><i>lorem ipsum</i><br /><p>lorem ipsum</p><p>lorem ipsum</p><b>lorem ipsum</b><br /><i>lorem ipsum</i><br /><b>lorem ipsum</b><br /><p>lorem ipsum</p><br /><br /><b>lorem ipsum</b><p>lorem ipsum</p><br /><i>lorem ipsum</i><br /><i>lorem ipsum</i><i>lorem ipsum</i><br /><b>lorem ipsum</b>"
    ]
    
    init() {
        super.init(nibName: nil, bundle: nil)
        title = "AttributedLabel"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
}

extension AttributedLabelDemoViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tweets.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellId = "CellId"
        let cell = (tableView.dequeueReusableCell(withIdentifier: cellId) as? TweetCell) ?? TweetCell(style: .default, reuseIdentifier: cellId)
        cell.tweet = tweets[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

class TweetCell: UITableViewCell {
    private let tweetLabel = UILabel()

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        contentView.addSubview(tweetLabel)
        
        let marginGuide = contentView.layoutMarginsGuide
        
        tweetLabel.translatesAutoresizingMaskIntoConstraints = false
        tweetLabel.leadingAnchor.constraint(equalTo: marginGuide.leadingAnchor).isActive = true
        tweetLabel.topAnchor.constraint(equalTo: marginGuide.topAnchor).isActive = true
        tweetLabel.trailingAnchor.constraint(equalTo: marginGuide.trailingAnchor).isActive = true
        tweetLabel.bottomAnchor.constraint(equalTo: marginGuide.bottomAnchor).isActive = true
        tweetLabel.numberOfLines = 0
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var tweet: String? {
        didSet {
            tweetLabel.attributedText = tweet?
                .htmlAttributed()
        }
    }
}

extension String {
    func htmlAttributed(
        font: UIFont = .systemFont(ofSize: 14),
        color: UIColor = .black,
        lineHeight: CGFloat = 24,
        kernAttribute: CGFloat = -0.5,
        alignment: NSTextAlignment = .center) -> NSAttributedString {
        
        let paragraph = NSMutableParagraphStyle()
        paragraph.minimumLineHeight = lineHeight
        paragraph.maximumLineHeight = lineHeight
        paragraph.alignment = alignment
        
        let f = UIFont.init(name: "Courier", size: 12)
        let b = UIFont.init(name: "Courier-Bold", size: 12)
        
        let noTag = Style("", [.font: f!])
        let bold = Style("b", style: Style.font(.boldSystemFont(ofSize: 12)))
        let italic = Style("i", style: Style.font(.italicSystemFont(ofSize: font.pointSize)))
        
        return self.style(baseStyle: noTag, tags:[
            bold,
            italic,
            Style.foregroundColor(color),
            Style.paragraphStyle(paragraph),
            Style.kern(kernAttribute)]
        ).attributedString
    }
}
