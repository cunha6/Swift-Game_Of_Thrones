import UIKit

class CharacterViewController: UIViewController {

    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: view.bounds.width / 2, height: 150)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        let collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: layout)
        collectionView.register(CharacterCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.backgroundColor = .systemBackground
        return collectionView
    }()
    
    private var data: [Character] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(collectionView)
        
        if let image = UIImage(named: "gotlogonovo") {
                    // Crie um UIImageView com a imagem
                    let imageView = UIImageView(image: image)
                    
                    // Ajuste o modo de exibição da imagem para escalar proporcionalmente
                    imageView.contentMode = .scaleAspectFit
                    
                    // Ajuste o tamanho da imagem conforme necessário
                    imageView.frame = CGRect(x: -40, y: 0, width: 120, height: 120)
                    
                    // Crie um contêiner de visualização personalizado para a imagem
                    let titleView = UIView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
                    titleView.addSubview(imageView)
                    
                    // Atribua o contêiner de visualização personalizado à barra de navegação
                    self.navigationItem.titleView = titleView
                }
        collectionView.delegate = self
        collectionView.dataSource = self
        fetchCharacters()
    }

    
    func fetchCharacters(){
        DispatchQueue.global(qos: .userInteractive).async {
            GOTService.fetch { result in
                DispatchQueue.main.async {
                    switch result {
                    case .success(let characters):
                        self.data = characters
                        self.collectionView.reloadData()
                    case .failure(let error):
                        print("Error fetching data: \(error.localizedDescription)")
                    }
                }
            }
        }
    }
}

extension CharacterViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let characterData = data[indexPath.item]
        let vc = DetailViewController(character: characterData)
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension CharacterViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? CharacterCollectionViewCell else {
            return UICollectionViewCell()
        }

        let character = data[indexPath.item]
        cell.configure(with: character)

        return cell
    }
}

