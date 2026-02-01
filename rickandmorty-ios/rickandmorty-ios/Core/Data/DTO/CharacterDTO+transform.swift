//
//  CharactersPageDTO+transform.swift
//  rickandmorty-ios
//
//  Created by Chang Chen, Ya-We on 20/1/26.
//

extension CharactersPageDTO {
    func transform() -> CharactersPage {
        let info: CharactersPage.Info = .init(
            count: self.info.count,
            pages: self.info.pages
        )

        let characters: [Character] = self.results.map {
            $0.transform()
        }
        return CharactersPage(info: info, results: characters)
    }
}

extension CharacterDTO {
    func transform() -> Character {

        return Character(
            id: self.id,
            name: self.name,
            status: Character.Status.init(rawValue: self.status) ?? .unknown,
            species: self.species,
            image: self.image,
            gender: Character.Gender.init(rawValue: self.gender) ?? .unknown,
            origin: CharacterLocationRef(
                name: self.origin.name,
                url: self.origin.url
            ),
            location: CharacterLocationRef(
                name: self.location.name,
                url: self.location.url
            )
        )

    }
}
