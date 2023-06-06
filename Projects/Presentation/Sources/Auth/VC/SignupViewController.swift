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
    // Add more error cases as needed
    
    var localizedDescription: String {
        switch self {
        case .missingFields:
            return "필수 항목이 누락되었습니다. 모든 필수 항목을 입력해주세요."
        case .invalidEmail:
            return "유효하지 않은 이메일 주소입니다. 유효한 이메일 주소를 입력해주세요."
        case .weakPassword:
            return "약한 비밀번호입니다. 보다 강력한 비밀번호를 선택해주세요."
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
        
//        let authService = AuthService() // AuthService 인스턴스 생성
//
//        viewModel = SignupViewModel(authService: authService,
//                                    gmailText: gmailFieldView.textField1.rx.text.asObservable(),
//                                    emailCodeText: gmailFieldView.textField2.rx.text.asObservable(),
//                                    studentKeyText: studentIdFieldView1.textField1.rx.text.asObservable(),
//                                    nameText: studentIdFieldView1.textField2.rx.text.asObservable(),
//                                    passwordText: studentIdFieldView2.textField1.rx.text.asObservable(),
//                                    githubLinkText: githubFieldView.textField.rx.text.asObservable())
//
//        signupButton.rx.tap
//            .subscribe(onNext: { [weak self] in
//                print("클릭")
//                self?.viewModel.signUp(gmail: self?.gmailFieldView.textField1.text,
//                                       emailCode: self?.gmailFieldView.textField2.text,
//                                       studentKey: self?.studentIdFieldView1.textField1.text,
//                                       name: self?.studentIdFieldView1.textField2.text,
//                                       password: self?.studentIdFieldView2.textField1.text,
//                                       githubLink: self?.githubFieldView.textField.text)
//            })
//            .disposed(by: disposeBag)
//
//        viewModel.signupResult
//            .subscribe(onNext: { [weak self] result in
//                switch result {
//                case .success:
//                    print("회원가입 성공")
//                case .failure(let error):
//                    print("회원가입 실패: \(error.localizedDescription)")
//                    print("보내니까 실패")
//                }
//            })
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

    public func signUp(gmail: String?, emailCode: String?, studentKey: String?, name: String?, password: String?, githubLink: String?) {
        guard let emailCode = emailCode, let studentKey = studentKey, let name = name, let email = gmail, let password = password else {
            signupResult.onNext(.failure(MyError.missingFields)) // 필수 필드가 누락된 경우 실패 처리
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
