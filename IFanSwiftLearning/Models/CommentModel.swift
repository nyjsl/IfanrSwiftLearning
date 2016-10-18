//
//  CommentModel.swift
//  IFanSwiftLearning
//
//  Created by 魏星 on 2016/10/17.
//  Copyright © 2016年 wx. All rights reserved.
//

import Foundation

struct CommentModel: Initable {
    
    var comment_id: String!
    var comment_author: String!
    var sso_id: String!
    var avatar: String!
    var comment_author_url: String!
    var comment_content: String!
    var comment_date: String!
    var comment_parent: String!
    var comment_rating_up: String!
    var comment_rating_down: String!
    var rating_status: String!
    var rated: String!
    var comment_mail_notify: String!
    var depth: String!
    var from_app: String!
    var from_app_name: String!
    var seo_detail_link: String!
    
    var isBig: Bool?
    
    init(dict: NSDictionary) {
        self.comment_id = dict["comment_id"] as? String ?? ""
        self.comment_author  = dict["comment_author"] as? String ?? ""
        self.sso_id  = dict["sso_id"] as? String ?? ""
        self.avatar     = dict["avatar"] as? String ?? ""
        self.comment_author_url = dict["comment_author_url"] as? String ?? ""
        self.comment_content    = dict["comment_content"] as? String ?? ""
        
        self.comment_date       = dict["comment_date"] as? String ?? ""
        self.comment_parent   = dict["comment_parent"] as? String ?? ""
        self.comment_rating_up = dict["comment_rating_up"] as? String ?? ""
        self.comment_rating_down   = dict["comment_rating_down"] as? String ?? ""
        self.rating_status    = dict["rating_status"] as? String ?? ""
        self.rated    = dict["rated"] as? String ?? ""
        self.comment_mail_notify      = dict["comment_mail_notify"] as? String ?? ""
        self.depth = dict["depth"] as? String ?? ""
        self.from_app = dict["from_app"] as? String ?? ""
        self.from_app_name = dict["from_app_name"] as? String ?? ""
    }

}