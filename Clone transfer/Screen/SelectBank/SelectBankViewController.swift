//
//  ViewController.swift
//  Clone transfer
//
//  Created by Suriya on 13/6/2564 BE.
//

import UIKit
import RxSwift
import RxCocoa

class SelectBankViewController: UIViewController, UICollectionViewDelegateFlowLayout {
    
    private let viewModel = SelectBankViewModel()
    private let bag = DisposeBag()

    @IBOutlet weak var bankCollection: UICollectionView!
    @IBOutlet weak var loading: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
                
        bankCollection.rx.setDelegate(self).disposed(by: bag)
        
        bankCollection.register(UINib(nibName: "SelectBankCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: String(describing: SelectBankCollectionViewCell.self))
        
        let result = viewModel.bankListSubject.asDriver(onErrorJustReturn: [])
        
        viewModel.loadingSubjext.asDriver(onErrorJustReturn: false)
            .drive(onNext: {(isLoad) in
                self.loading.isHidden = isLoad
                self.bankCollection.isHidden = !isLoad
            })
            .disposed(by: bag)
        
        result.drive(bankCollection.rx.items(cellIdentifier: "SelectBankCollectionViewCell", cellType: SelectBankCollectionViewCell.self)) {(row, bank, cell) in
            cell.bind(bank)
        }.disposed(by: bag)
        
        bankCollection.rx.willDisplayCell
            .subscribe(onNext: {(cell, indexPath) in
                cell.alpha = 0
                UIView.animate(withDuration: 0.5, delay: 0.05 * Double(indexPath.row), animations: {
                    cell.alpha = 1
                })
            })
            .disposed(by: bag)
        
        viewModel.getBankList()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.width
        let cellWidth = (width - 30) / 3
        return CGSize(width: cellWidth, height: 100)
    }
}

