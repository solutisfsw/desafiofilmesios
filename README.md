# [iOS] Desafio Viciados em Filmes

# Contexto
Preciso de um app para manter meu vício por filmes em dia. O app terá duas telas. Na tela inicial preciso de um esquema de abas para mostrar 3 listas: 
    * Os filmes mais recentes
    * Os filmes mais populares
    * Os filmes melhores avaliados
Ao clicar em um filme preciso ver todos os detalhes possíveis do filme clicado.
De tempos em tempos eu gosto de seguir um filme então gostaria de marcar um deles como favorito. (preciso também de um indicativo visual que esse filme é favorito ou não na tela inicial) 

# Requisitos
 - Codificar em Swift
 - Deve dar suporte ao iOS 9
 - Seguir as diretrizes de interface da Apple (https://developer.apple.com/design/human-interface-guidelines/ios/overview)
 - Para a listagem usar TableView (https://developer.apple.com/design/human-interface-guidelines/ios/views/tables/) (https://developer.apple.com/documentation/uikit/uitableview)
 - Para o esquema de abas usar o componente de TabBar do UIKit (https://developer.apple.com/design/human-interface-guidelines/ios/bars/tab-bars/) (https://developer.apple.com/documentation/uikit/uitabbar)
 - Nas requisições REST fazer utilizando a API Nativa ou uma biblioteca como o Alamofire (a escolha) (colocar algum indicativo de loading: https://developer.apple.com/design/human-interface-guidelines/ios/app-architecture/loading/)
 - Todas as requisições estão no movieDB (https://developers.themoviedb.org)
    .Filmes mais populares: https://developers.themoviedb.org/3/movies/get-popular-movies
    .Filmes melhores avaliados: https://developers.themoviedb.org/3/movies/get-top-rated-movies
    .Filmes mais recentes: https://developers.themoviedb.org/3/movies/get-latest-movie
    .Detalhes de um filme: https://developers.themoviedb.org/3/movies/get-movie-details
 - Os filmes favoritos serão armazenados de forma segura no dispositivo, usando o Keychain do iOS (https://developer.apple.com/documentation/security/keychain_services) (tutorial: https://www.raywenderlich.com/9240-keychain-services-api-tutorial-for-passwords-in-swift)
 
# Protótipo
//Anexar telas

# Entrega
Você deve fazer o fork desse repositório na sua conta e após finalizado o desafio submeter um pull request para avaliação
