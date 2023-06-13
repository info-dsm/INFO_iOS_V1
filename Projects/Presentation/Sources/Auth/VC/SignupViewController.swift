import UIKit
import SnapKit
import Then
import RxCocoa
import RxSwift
import Core
import INFOKit
import Data

enum MyError: Error {
    case missingFields
    case invalidEmail
    case weakPassword
    case checkCode

    var localizedDescription: String {
        switch self {
        case .missingFields:
            return "필수 항목이 누락되었습니다. 모든 필수 항목을 입력해주세요."
        case .invalidEmail:
            return "유효하지 않은 이메일 주소입니다. 유효한 이메일 주소를 입력해주세요."
        case .weakPassword:
            return "약한 비밀번호입니다. 보다 강력한 비밀번호를 선택해주세요."
        case .checkCode:
            return "유효하지 않은 인증번호입니다. 유효한 인증번호를 입력해주세요."
        }
    }
}


public class SignupViewController: UIViewController {

    private let disposeBag = DisposeBag()

    public var factory: ModuleFactoryInterface!

    public var viewModel: SignupViewModel!

    private lazy var purpleLogo = UIImageView().then {
        $0.image = INFOKitAsset.Assets.purpleLogo.image
    }

    private lazy var studentLoginTitle = UILabel().then {
        $0.text = "학생 회원가입"
        $0.textColor = .black
        $0.font = .systemFont(ofSize: 36.0, weight: .bold)
    }

    private lazy var gmailFieldView = InfoTwoFieldView(title: "이메일", placeholder1: "이메일을 입력해주세요.", placeholder2: "인증번호를 입력해주세요.", buttonVisible: true)
    private lazy var studentIdFieldView1 = InfoTwoFieldView(title: "이름 · 학번", placeholder1: "이름을 입력해주세요.", placeholder2: "학번을 입력해주세요.")
    private lazy var studentIdFieldView2 = InfoTwoFieldView(title: "이름 · 학번", placeholder1: "비밀번호를 입력해주세요.", placeholder2: "비밀번호를 다시 입력해주세요.")
    private lazy var githubFieldView = InfoOneFieldView(title: "깃허브 주소", placeholder: "깃허브 주소를 입력해주세요.")
    private lazy var signupButton = InfoCustomButton(title: "회원가입", backgroundColor: INFOKitAsset.Colors.mainColor.color, titleColor: .white)

    private lazy var userInfoStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.spacing = 4.0
        $0.addArrangedSubview(InfoLabel(title: "info 기존 회원이신가요?"))
        $0.addArrangedSubview(InfoButton(buttonTitle: "로그인", underlineEnabled: false, titleColor: INFOKitAsset.Colors.mainColor.color))
    }

    public override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        layout()

        let authService = AuthService()

        //Observable 이라서 생기는 문제 나중에 리펙 ㄱ ✌️
        viewModel = SignupViewModel(authService: authService,
                                    gmailText: gmailFieldView.textField1.rx.controlEvent(.editingDidEndOnExit).map { [weak self] in self?.gmailFieldView.textField1.text },
                                    emailCodeText: gmailFieldView.textField2.rx.controlEvent(.editingDidEndOnExit).map { [weak self] in self?.gmailFieldView.textField2.text },
                                    studentKeyText: studentIdFieldView1.textField1.rx.controlEvent(.editingDidEndOnExit).map { [weak self] in self?.studentIdFieldView1.textField1.text },
                                    nameText: studentIdFieldView1.textField2.rx.controlEvent(.editingDidEndOnExit).map { [weak self] in self?.studentIdFieldView1.textField2.text },
                                    passwordText: studentIdFieldView2.textField1.rx.controlEvent(.editingDidEndOnExit).map { [weak self] in self?.studentIdFieldView2.textField1.text },
                                    githubLinkText: githubFieldView.textField.rx.controlEvent(.editingDidEndOnExit).map { [weak self] in self?.githubFieldView.textField.text })

        signupButton.rx.tap
            .throttle(.milliseconds(500), scheduler: MainScheduler.instance)
            .subscribe(onNext: { [weak self] in
                guard let self = self else { return }
                print("클릭")

                self.viewModel.signUp(gmail: self.gmailFieldView.textField1.text,
                                      emailCode: self.gmailFieldView.textField2.text,
                                      studentKey: self.studentIdFieldView1.textField1.text,
                                      name: self.studentIdFieldView1.textField2.text,
                                      password: self.studentIdFieldView2.textField1.text,
                                      githubLink: self.githubFieldView.textField.text!)
            })
            .disposed(by: disposeBag)

        viewModel.signupResult
            .subscribe(onNext: { [weak self] result in
                switch result {
                case .success:
                    print("회원가입 성공")
                case .failure(let error):
                    print("회원가입 실패: \(error.localizedDescription)")
                }
            })
            .disposed(by: disposeBag)

        gmailFieldView.button1.rx.tap
            .throttle(.milliseconds(500), scheduler: MainScheduler.instance)
            .subscribe(onNext: { [weak self] in
                guard let email = self?.gmailFieldView.textField1.text else { return }
                self?.viewModel.sendCode(email: email)
            })
            .disposed(by: disposeBag)

        gmailFieldView.button2.rx.tap
            .throttle(.milliseconds(500), scheduler: MainScheduler.instance)
            .subscribe(onNext: { [weak self] in
                guard let email = self?.gmailFieldView.textField1.text else { return }
                guard let code = self?.gmailFieldView.textField2.text else { return }
                self?.viewModel.checkCode(email: email, data: code, type: "SIGNUP_EMAIL")
            })
    }

    func layout() {
        view.addSubviews([
            purpleLogo,
            studentLoginTitle,
            gmailFieldView,
            studentIdFieldView1,
            studentIdFieldView2,
            githubFieldView,
            signupButton,
            userInfoStackView
        ])

        purpleLogo.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(50.0)
            $0.left.equalToSuperview().offset(50.0)
            $0.width.equalTo(58.0)
            $0.height.equalTo(20.0)
        }

        studentLoginTitle.snp.makeConstraints {
            $0.top.equalTo(purpleLogo.snp.bottom).offset(10.0)
            $0.left.equalTo(purpleLogo.snp.left)
        }

        gmailFieldView.snp.makeConstraints {
            $0.top.equalTo(studentLoginTitle.snp.bottom).offset(14.0)
            $0.leading.trailing.equalToSuperview().inset(50.0)
            $0.height.equalTo(119.0)
        }

        studentIdFieldView1.snp.makeConstraints {
            $0.top.equalTo(gmailFieldView.snp.bottom).offset(30.0)
            $0.leading.trailing.equalToSuperview().inset(50.0)
            $0.height.equalTo(119.0)
        }

        studentIdFieldView2.snp.makeConstraints {
            $0.top.equalTo(studentIdFieldView1.snp.bottom).offset(30.0)
            $0.leading.trailing.equalToSuperview().inset(50.0)
            $0.height.equalTo(119.0)
        }

        githubFieldView.snp.makeConstraints {
            $0.top.equalTo(studentIdFieldView2.snp.bottom).offset(30.0)
            $0.leading.trailing.equalToSuperview().inset(50.0)
            $0.height.equalTo(69.0)
        }

        signupButton.snp.makeConstraints {
            $0.top.equalTo(githubFieldView.snp.bottom).offset(40.0)
            $0.leading.trailing.equalToSuperview().inset(50.0)
            $0.height.equalTo(40.0)
        }

        userInfoStackView.snp.makeConstraints {
            $0.top.equalTo(signupButton.snp.bottom).offset(14.0)
            $0.centerX.equalToSuperview()
            $0.bottom.equalToSuperview().inset(80.0)
        }
    }
}

public class SignupViewModel {

    public let authService: AuthService
    private let disposeBag = DisposeBag()

    let signupResult: PublishSubject<Result<Void, Error>> = PublishSubject()
    let sendCodeResult: PublishSubject<Result<Void, Error>> = PublishSubject()
    let checkCodeResult: PublishSubject<Result<Void, Error>> = PublishSubject()


    public init(authService: AuthService,
                gmailText: Observable<String?>,
                emailCodeText: Observable<String?>,
                studentKeyText: Observable<String?>,
                nameText: Observable<String?>,
                passwordText: Observable<String?>,
                githubLinkText: Observable<String?>) {

        self.authService = authService

        Observable.combineLatest(gmailText,
                                 emailCodeText,
                                 studentKeyText,
                                 nameText,
                                 passwordText,
                                 githubLinkText)
        .subscribe(onNext: { [weak self] (gmail, emailCode, studentKey, name, password, githubLink) in
            self?.signUp(gmail: gmail, emailCode: emailCode, studentKey: studentKey, name: name, password: password, githubLink: githubLink)
        })
        .disposed(by: disposeBag)
    }

    func sendCode(email: String) {
        authService.sendCode(email: email)
            .subscribe(onSuccess: { [weak self] in
                self?.sendCodeResult.onNext(.success(())) // 코드 전송 성공 처리 😎
            }, onError: { [weak self] error in
                self?.sendCodeResult.onNext(.failure(error)) // 코드 전송 실패 처리 🥲
            })
            .disposed(by: disposeBag)
    }

    func checkCode(email: String, data: String, type: String) {
        authService.checkCode(email: email, data: data, type: type)
            .subscribe(onSuccess: { [weak self] in
                self?.checkCodeResult.onNext(.success(()))
            }, onError: { [weak self] error in
                self?.checkCodeResult.onNext(.failure(error))
            })
            .disposed(by: disposeBag)
    }


    public func signUp(gmail: String?, emailCode: String?, studentKey: String?, name: String?, password: String?, githubLink: String?) {
        guard let emailCode = emailCode, let studentKey = studentKey, let name = name, let email = gmail, let password = password else {
            signupResult.onNext(.failure(MyError.missingFields))
            return
        }

        authService.signUp(emailCode: emailCode, studentKey: studentKey, name: name, email: email, password: password, githubLink: githubLink)
            .subscribe(onSuccess: { [weak self] in
                self?.signupResult.onNext(.success(()))
            }, onError: { [weak self] error in
                self?.signupResult.onNext(.failure(error))
            })
            .disposed(by: disposeBag)
    }
}

//import UIKit
//import SnapKit
//import Then
//import RxCocoa
//import RxSwift
//import Core
//import INFOKit
//import Data
//
//enum MyError: Error {
//    case missingFields
//    case invalidEmail
//    case weakPassword
//    case checkCode
//
//    var localizedDescription: String {
//        switch self {
//        case .missingFields:
//            return "필수 항목이 누락되었습니다. 모든 필수 항목을 입력해주세요."
//        case .invalidEmail:
//            return "유효하지 않은 이메일 주소입니다. 유효한 이메일 주소를 입력해주세요."
//        case .weakPassword:
//            return "약한 비밀번호입니다. 보다 강력한 비밀번호를 선택해주세요."
//        case .checkCode:
//            return "유효하지 않은 인증번호입니다. 유효한 인증번호를 입력해주세요."
//        }
//    }
//}
//
//public class SignupViewController: UIViewController {
//
//    private let disposeBag = DisposeBag()
//
//    public var factory: ModuleFactoryInterface!
//
//    public var viewModel: SignupViewModel!
//
//    private lazy var purpleLogo = UIImageView().then {
//        $0.image = INFOKitAsset.Assets.purpleLogo.image
//    }
//
//    private lazy var studentLoginTitle = UILabel().then {
//        $0.text = "학생 회원가입"
//        $0.textColor = .black
//        $0.font = .systemFont(ofSize: 36.0, weight: .bold)
//    }
//
//    private lazy var gmailFieldView = InfoTwoFieldView(title: "이메일", placeholder1: "이메일을 입력해주세요.", placeholder2: "인증번호를 입력해주세요.", buttonVisible: true)
//    private lazy var studentIdFieldView1 = InfoTwoFieldView(title: "이름 · 학번", placeholder1: "이름을 입력해주세요.", placeholder2: "학번을 입력해주세요.")
//    private lazy var studentIdFieldView2 = InfoTwoFieldView(title: "이름 · 학번", placeholder1: "비밀번호를 입력해주세요.", placeholder2: "비밀번호를 다시 입력해주세요.")
//    private lazy var githubFieldView = InfoOneFieldView(title: "깃허브 주소", placeholder: "깃허브 주소를 입력해주세요.")
//    private lazy var signupButton = InfoCustomButton(title: "회원가입", backgroundColor: INFOKitAsset.Colors.mainColor.color, titleColor: .white)
//
//    private lazy var userInfoStackView = UIStackView().then {
//        $0.axis = .horizontal
//        $0.spacing = 4.0
//        $0.addArrangedSubview(InfoLabel(title: "info 기존 회원이신가요?"))
//        $0.addArrangedSubview(InfoButton(buttonTitle: "로그인", underlineEnabled: false, titleColor: INFOKitAsset.Colors.mainColor.color))
//    }
//
//    public override func viewDidLoad() {
//        super.viewDidLoad()
//
//        view.backgroundColor = .white
//        layout()
//
//        let authService = AuthService()
//
//        viewModel = SignupViewModel(authService: authService)
//
//        bindViewModel()
//    }
//
//    private func bindViewModel() {
//        let input = SignupViewModel.Input(
//            gmail: gmailFieldView.textField1.rx.text.orEmpty.asObservable(),
//            emailCode: gmailFieldView.textField2.rx.text.orEmpty.asObservable(),
//            studentKey: studentIdFieldView1.textField1.rx.text.orEmpty.asObservable(),
//            name: studentIdFieldView1.textField2.rx.text.orEmpty.asObservable(),
//            password: studentIdFieldView2.textField1.rx.text.orEmpty.asObservable(),
//            githubLink: githubFieldView.textField.rx.text.orEmpty.asObservable(),
//            signupButtonTapped: signupButton.rx.tap.asObservable()
//        )
//
//        let output = viewModel.trans(from: input)
//
//        output.enableSignupButton
//            .drive(signupButton.rx.isEnabled)
//            .disposed(by: disposeBag)
//
//        output.showLoading
//            .drive(UIApplication.shared.rx.isNetworkActivityIndicatorVisible)
//            .disposed(by: disposeBag)
//
//        output.showError
//            .drive(onNext: { [weak self] error in
//                self?.showErrorAlert(error: error)
//            })
//            .disposed(by: disposeBag)
//
////        output.signupSuccess
////            .drive(onNext: { [weak self] in
////                self?.factory.showMain()
////            })
////            .disposed(by: disposeBag)
//    }
//
//    private func showErrorAlert(error: Error) {
//        let alertController = UIAlertController(title: "오류", message: error.localizedDescription, preferredStyle: .alert)
//        alertController.addAction(UIAlertAction(title: "확인", style: .default, handler: nil))
//        present(alertController, animated: true, completion: nil)
//    }
//
//    private func layout() {
//        view.addSubview(purpleLogo)
//        purpleLogo.snp.makeConstraints {
//            $0.centerX.equalToSuperview()
//            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(30.0)
//            $0.width.equalTo(100.0)
//            $0.height.equalTo(120.0)
//        }
//
//        view.addSubview(studentLoginTitle)
//        studentLoginTitle.snp.makeConstraints {
//            $0.top.equalTo(purpleLogo.snp.bottom).offset(35.0)
//            $0.leading.trailing.equalToSuperview().inset(32.0)
//        }
//
//        view.addSubview(gmailFieldView)
//        gmailFieldView.snp.makeConstraints {
//            $0.top.equalTo(studentLoginTitle.snp.bottom).offset(70.0)
//            $0.leading.trailing.equalToSuperview().inset(32.0)
//            $0.height.equalTo(80.0)
//        }
//
//        view.addSubview(studentIdFieldView1)
//        studentIdFieldView1.snp.makeConstraints {
//            $0.top.equalTo(gmailFieldView.snp.bottom).offset(20.0)
//            $0.leading.trailing.equalToSuperview().inset(32.0)
//            $0.height.equalTo(80.0)
//        }
//
//        view.addSubview(studentIdFieldView2)
//        studentIdFieldView2.snp.makeConstraints {
//            $0.top.equalTo(studentIdFieldView1.snp.bottom).offset(20.0)
//            $0.leading.trailing.equalToSuperview().inset(32.0)
//            $0.height.equalTo(80.0)
//        }
//
//        view.addSubview(githubFieldView)
//        githubFieldView.snp.makeConstraints {
//            $0.top.equalTo(studentIdFieldView2.snp.bottom).offset(20.0)
//            $0.leading.trailing.equalToSuperview().inset(32.0)
//            $0.height.equalTo(60.0)
//        }
//
//        view.addSubview(signupButton)
//        signupButton.snp.makeConstraints {
//            $0.top.equalTo(githubFieldView.snp.bottom).offset(30.0)
//            $0.leading.trailing.equalToSuperview().inset(32.0)
//            $0.height.equalTo(50.0)
//        }
//
//        view.addSubview(userInfoStackView)
//        userInfoStackView.snp.makeConstraints {
//            $0.top.equalTo(signupButton.snp.bottom).offset(20.0)
//            $0.centerX.equalToSuperview()
//        }
//    }
//}
//
//public struct SignupViewModel: ViewModelType {
//
//    public struct Input {
//        let gmail: Observable<String>
//        let emailCode: Observable<String>
//        let studentKey: Observable<String>
//        let name: Observable<String>
//        let password: Observable<String>
//        let githubLink: Observable<String>
//        let signupButtonTapped: Observable<Void>
//    }
//
//    public struct Output {
//        let enableSignupButton: Driver<Bool>
//        let showLoading: Driver<Bool>
//        let showError: Driver<Error>
//        let signupSuccess: Driver<Void>
//    }
//
//    public func trans(from input: inout Input) -> Output {
//        let enableSignupButton = Observable.combineLatest(input.gmail, input.emailCode, input.studentKey, input.name, input.password, input.githubLink)
//            .map { gmail, emailCode, studentKey, name, password, githubLink in
//                return !gmail.isEmpty && !emailCode.isEmpty && !studentKey.isEmpty && !name.isEmpty && !password.isEmpty && !githubLink.isEmpty
//            }
//            .startWith(false)
//            .asDriver(onErrorJustReturn: false)
//
//        let signupRequest = input.signupButtonTapped
//            .withLatestFrom(Observable.combineLatest(input.gmail, input.emailCode, input.studentKey, input.name, input.password, input.githubLink))
//            .flatMapLatest { [weak self] gmail, emailCode, studentKey, name, password, githubLink -> Observable<Result<Void, Error>> in
//                guard let self = self else {
//                    return Observable.just(.failure(MyError.missingFields))
//                }
//
//                guard self.isValidEmail(email: gmail) else {
//                    return Observable.just(.failure(MyError.invalidEmail))
//                }
//
//                guard self.isValidPassword(password: password) else {
//                    return Observable.just(.failure(MyError.weakPassword))
//                }
//
//                // 여기서 인증번호 체크를 하고 성공 시 회원가입 요청을 보냄
//                return self.authService.checkCode(emailCode)
//                    .flatMap { codeCheckResult -> Observable<Result<Void, Error>> in
//                        if codeCheckResult {
//                            return self.authService.signup(gmail: gmail, studentKey: studentKey, name: name, password: password, githubLink: githubLink)
//                        } else {
//                            return Observable.just(.failure(MyError.checkCode))
//                        }
//                    }
//            }
//            .share()
//
//        let showLoading = signupRequest
//            .map { _ in true }
//            .startWith(false)
//            .asDriver(onErrorJustReturn: false)
//
//        let showError = signupRequest
//            .flatMap { result -> Observable<Error> in
//                switch result {
//                case .success:
//                    return Observable.empty()
//                case .failure(let error):
//                    return Observable.just(error)
//                }
//            }
//            .asDriver(onErrorJustReturn: MyError.missingFields)
//
//        let signupSuccess = signupRequest
//            .filter { $0.isSuccess }
//            .map { _ in }
//            .asDriver(onErrorJustReturn: ())
//
//        return Output(
//            enableSignupButton: enableSignupButton,
//            showLoading: showLoading,
//            showError: showError,
//            signupSuccess: signupSuccess
//        )
//    }
//
//
//    private let authService: AuthService
//
//    public init(authService: AuthService) {
//        self.authService = authService
//    }
//
//    private func isValidEmail(email: String) -> Bool {
//
//        return true
//    }
//
//    private func isValidPassword(password: String) -> Bool {
//
//        return true
//    }
//}
