//
//  SearchViewController.swift
//  YoutubeChannelFilter
//
//  Created by gamepub on 2022/06/28.
//

import UIKit
import SnapKit
import RealmSwift

final class SearchViewController: UIViewController {
    private var records = [SearchRecord]()
    private let backBtnImageView = UIImageView()
    private let searchBar = UISearchBar()
    private let searchRecordTableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 241/255, green: 243/255, blue: 248/255, alpha: 1)
        self.navigationController?.navigationBar.isHidden = true
        self.navigationController?.tabBarController?.tabBar.isHidden = true
        
        setBackBtnImageView()
        setSearchBar()
        setSearchRecordTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        fetchRecords()
        searchRecordTableView.reloadData()
    }
    
    private func fetchRecords() {
        records = Array(try! Realm().objects(SearchRecord.self).sorted(byKeyPath: "date", ascending: false))
    }
    
    private func setBackBtnImageView() {
        backBtnImageView.image = UIImage(named: "arrow.backward")
        backBtnImageView.tintColor = .darkGray
        backBtnImageView.isUserInteractionEnabled = true
        let gesture = UITapGestureRecognizer(target: self, action: #selector(popView(_:)))
        backBtnImageView.addGestureRecognizer(gesture)
        view.addSubview(backBtnImageView)
        backBtnImageView.snp.makeConstraints { imageView in
            imageView.leading.equalTo(view.safeAreaLayoutGuide).inset(10)
            imageView.width.height.equalTo(30)
        }
    }
    
    private func setSearchBar() {
        searchBar.placeholder = "YouTube 검색"
        searchBar.delegate = self
        searchBar.barTintColor = UIColor(red: 241/255, green: 243/255, blue: 248/255, alpha: 1)
        searchBar.setBackgroundImage(UIImage(), for: .any, barMetrics: .default)
        view.addSubview(searchBar)
        searchBar.snp.makeConstraints { searchBar in
            searchBar.leading.equalTo(backBtnImageView.snp.trailing)
            searchBar.top.trailing.equalTo(view.safeAreaLayoutGuide)
        }

        backBtnImageView.snp.makeConstraints { imageView in
            imageView.centerY.equalTo(searchBar.snp.centerY)
        }
    }
    
    private func setSearchRecordTableView() {
        searchRecordTableView.register(SearchRecordTableViewCell.self,
                                       forCellReuseIdentifier: SearchRecordTableViewCell.reuseIdentifier)
        searchRecordTableView.register(UITableViewHeaderFooterView.self,
                                       forHeaderFooterViewReuseIdentifier: "searchRecordTableHeaderView")
        searchRecordTableView.dataSource = self
        searchRecordTableView.delegate = self
        searchRecordTableView.backgroundColor = UIColor(red: 241/255, green: 243/255, blue: 248/255, alpha: 1)
        view.addSubview(searchRecordTableView)
        searchRecordTableView.snp.makeConstraints { tableView in
            tableView.top.equalTo(searchBar.snp.bottom)
            tableView.leading.trailing.bottom.equalTo(view)
        }
    }
    
    @objc private func popView(_ sender: UITapGestureRecognizer) {
        navigationController?.popViewController(animated: true)
    }
}

extension SearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        try! Realm().write({
            try! Realm().add(SearchRecord(title: self.searchBar.text))
        })
        print(self.searchBar.text!)
        navigationController?.popViewController(animated: true)
    }
}

extension SearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        try! Realm().objects(SearchRecord.self).count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchRecordTableViewCell.reuseIdentifier)
                as? SearchRecordTableViewCell,
              let title = records[indexPath.row].title else { return UITableViewCell() }
        cell.setTitleLabelText(title: title)
        cell.indexPath = indexPath
        //cell.searchRecordTableViewCellDelegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView,
                   commit editingStyle: UITableViewCell.EditingStyle,
                   forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            try! Realm().write {
                try! Realm().delete(records[indexPath.row])
            }
            records.remove(at: indexPath.row)
            searchRecordTableView.reloadData()
            
            //tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}

extension SearchViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = searchRecordTableView.cellForRow(at: indexPath) as? SearchRecordTableViewCell,
              let searchText = cell.titleLabel.text else { return }
        print(searchText)
        navigationController?.popViewController(animated: true)
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let headerView = tableView
                .dequeueReusableHeaderFooterView(withIdentifier: "searchRecordTableHeaderView") else { return UIView() }
        headerView.backgroundView = UIView(frame: headerView.bounds)
        headerView.backgroundView?.backgroundColor = UIColor(red: 241/255, green: 243/255, blue: 248/255, alpha: 1)

        if #available(iOS 14.0, *) {
            var content = headerView.defaultContentConfiguration()
            content.text = "최근 검색어"
            headerView.contentConfiguration = content
        } else {
            headerView.textLabel?.text = "최근 검색어"
        }

        return headerView
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}

//extension SearchViewController: SearchRecordTableViewCellDelegate {
//    func removeCell(indexPath: IndexPath) {
//        try! Realm().write {
//            try! Realm().delete(records[indexPath.row])
//        }
//        records.remove(at: indexPath.row)
//        searchRecordTableView.reloadData()
//    }
//}
