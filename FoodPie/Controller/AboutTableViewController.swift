//
//  AboutTableViewController.swift
//  FoodPie
//
//  Created by ciggo on 4/15/20.
//  Copyright © 2020 ciggo. All rights reserved.
//

import UIKit

class AboutTableViewController: UITableViewController {
    var sectionTitles = ["Feedback", "Follow Us"]
    var sectionContent = [
    [(image: "store", text: "Rate us on App Store", link : "https://www.apple.com/ios/app-store/"),
        (image: "chat", text: "Tell us your feedback", link : "http://www.appcoda.com/contact")],
    [(image: "twitter", text: "Twitter", link: "https:// twitter.com/appcodamobile"),
    (image: "facebook", text: "Facebook", link: "https: //facebook.com/appcodamobile"),
    (image: "instagram", text: "Instagram", link: "http s://www.instagram.com/appcodadotcom")]]

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()

         if let customFont = UIFont(name: "Rubik-Medium", size: 40.0) {
                   navigationController?.navigationBar.largeTitleTextAttributes = [ NSAttributedString.Key.foregroundColor: UIColor(red: 231, green: 76, blue: 60), NSAttributedString.Key.font: customFont ]
        }

        navigationController?.navigationBar.prefersLargeTitles = true
        tableView.tableFooterView = UIView()
        tableView.cellLayoutMarginsFollowReadableWidth = true
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return sectionTitles.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sectionContent[section].count
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionTitles[section]
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AboutCell", for: indexPath)
        let cellData = sectionContent[indexPath.section][indexPath.row]
        cell.textLabel?.text = cellData.text
        cell.imageView?.image = UIImage(named: cellData.image)

        return cell
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60.0
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let link = sectionContent[indexPath.section][indexPath.row].link

        switch indexPath.section {
        case 0:
            if indexPath.row == 0 {
                if let url = URL(string: link) {
                    UIApplication.shared.open(url)
                }
            } else if indexPath.row == 1 {
                performSegue(withIdentifier: "showWebView", sender: self)
            }
        default:
            break
        }

        tableView.deselectRow(at: indexPath, animated: false)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if "showWebView" == segue.identifier {
            let destinationController = segue.destination as! WebViewController
            if let indexPath = tableView.indexPathForSelectedRow {
                destinationController.targetUrl = sectionContent[indexPath.section][indexPath.row].link
            }

        }
    }
}
