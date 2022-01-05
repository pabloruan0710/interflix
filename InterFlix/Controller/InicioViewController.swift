//
//  InicioViewController.swift
//  InterFlix
//
//  Created by Pablo Ruan Ribeiro Silva  on 05/01/22.
//

import UIKit

enum Categorias: String, CaseIterable {
    case populares = "Populares"
    case lancamentos = "Lançamentos"
    case recomendados = "Recomendados"
    case emCartaz = "Em Cartaz"
}

class InicioViewController: UIViewController {
    
    private lazy var viewHeader: UIView = {
        let viewHeader = UIView()
        viewHeader.translatesAutoresizingMaskIntoConstraints = false
        return viewHeader
    }()
    
    private lazy var labelTitle: UILabel = {
        let labelTitle = UILabel()
        labelTitle.translatesAutoresizingMaskIntoConstraints = false
        labelTitle.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        labelTitle.textColor = .systemPink
        labelTitle.textAlignment = .center
        return labelTitle
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(CategoriaTableViewCell.self, forCellReuseIdentifier: CategoriaTableViewCell.identifier())
        return tableView
    }()
    var categorias: [Categorias] = Categorias.allCases
    
    var filmesPopulares: [Filme] = []
    var filmesRecomendados: [Filme] = []
    var filmesEmCartaz: [Filme] = []
    var filmesLancamentos: [Filme] = []
    
    
    public init(title: String) {
        super.init(nibName: nil, bundle: nil)
        labelTitle.text = title
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        obtenhaFilmes()
    }
    
    private func setup() {
        buildViewHierarchy()
        addConstraints()
    }
    
    private func buildViewHierarchy() {
        view.addSubview(viewHeader)
        view.addSubview(tableView)
        viewHeader.addSubview(labelTitle)
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            viewHeader.topAnchor.constraint(equalTo: view.topAnchor),
            viewHeader.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            viewHeader.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            viewHeader.heightAnchor.constraint(equalToConstant: 100),
            labelTitle.bottomAnchor.constraint(equalTo: viewHeader.bottomAnchor, constant: -8),
            labelTitle.leadingAnchor.constraint(equalTo: viewHeader.leadingAnchor, constant: 8),
            labelTitle.trailingAnchor.constraint(equalTo: viewHeader.trailingAnchor, constant: -8),
            tableView.topAnchor.constraint(equalTo: viewHeader.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func obtenhaFilmes() {
        FilmeService.obtenhaPopulares { [weak self] filmes, msg in
            self?.filmesPopulares = filmes
            DispatchQueue.main.async {
                guard let indexSection = self?.categorias.firstIndex(of: .populares) else {
                    return
                }
                self?.tableView.reloadSections(IndexSet(integer: indexSection), with: .automatic)
            }
        }
        
        FilmeService.obtenhaRecomendados { [weak self] filmes, msg in
            self?.filmesRecomendados = filmes
            DispatchQueue.main.async {
                guard let indexSection = self?.categorias.firstIndex(of: .recomendados) else {
                    return
                }
                self?.tableView.reloadSections(IndexSet(integer: indexSection), with: .automatic)
            }
        }
        
        FilmeService.obtenhaEmCartaz { [weak self] filmes, msg in
            self?.filmesEmCartaz = filmes
            DispatchQueue.main.async {
                guard let indexSection = self?.categorias.firstIndex(of: .emCartaz) else {
                    return
                }
                self?.tableView.reloadSections(IndexSet(integer: indexSection), with: .automatic)
            }
        }
        
        FilmeService.obtenhaLancamentos { [weak self] filmes, msg in
            self?.filmesLancamentos = filmes
            DispatchQueue.main.async {
                guard let indexSection = self?.categorias.firstIndex(of: .lancamentos) else {
                    return
                }
                self?.tableView.reloadSections(IndexSet(integer: indexSection), with: .automatic)
            }
        }
    }
}

extension InicioViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return categorias.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CategoriaTableViewCell.identifier()) as! CategoriaTableViewCell
        
        switch categorias[indexPath.section] {
        case .emCartaz:
            cell.updateView(filmesEmCartaz)
        case .lancamentos:
            cell.updateView(filmesLancamentos)
        case .populares:
            cell.updateView(filmesPopulares)
        case .recomendados:
            cell.updateView(filmesRecomendados)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140.0
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return categorias[section].rawValue
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header : UIView = {
            let v = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 30))
            let label = UILabel(frame: CGRect(x: 12, y: 0, width: UIScreen.main.bounds.width-56, height: v.frame.height))
            v.addSubview(label)
            
            let normalTitulo = NSMutableAttributedString(string: "Filmes ")
            let boldTitulo = NSMutableAttributedString(string: categorias[section].rawValue, attributes:[NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 15)])
            normalTitulo.append(boldTitulo)
            label.attributedText = normalTitulo
            
            return v
        }()
        return header
    }
}

