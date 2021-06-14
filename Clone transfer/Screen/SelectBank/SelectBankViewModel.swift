//
//  SelectBankViewModel.swift
//  Clone transfer
//
//  Created by Suriya on 14/6/2564 BE.
//

import Foundation
import RxSwift
import Moya
import Moya_ObjectMapper

class SelectBankViewModel {
    
    private let bag = DisposeBag()
    let bankListSubject: PublishSubject<[Bank]> = PublishSubject()
    let loadingSubjext: PublishSubject<Bool> = PublishSubject()
    fileprivate let service = MoyaProvider<TransferService>(plugins: [VerbosePlugin(verbose: true)])
    
    func getBankList() {
        loadingSubjext.onNext(false)
        service.rx.request(.getBankList)
            .filterSuccessfulStatusCodes()
            .mapObject(BankList.self)
            .observeOn(ConcurrentDispatchQueueScheduler(qos: .background))
            .subscribeOn(MainScheduler.instance)
            .subscribe(onSuccess: {(response) in
                self.loadingSubjext.onNext(true)
                if let bankList = response.bankList{
                    self.bankListSubject.onNext(bankList)
                }
            }, onError: {(error) in
                self.loadingSubjext.onNext(true)
                print(error)
            })
            .disposed(by: bag)
    }
}
