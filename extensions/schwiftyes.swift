import schwiftyes

extension schwiftyes.ComponentManager {
    enum ComponentAndEntityError: Error {
        case noEntity
        case noComponent
    }

	func getResolvedComponent<T: schwiftyes.Component>(entities: [schwiftyes.Entity], component: T.Type) throws -> T {
		var (_, comp) = try getComponentAndEntity(entities: entities, component: component)
		return comp
	}

    func getComponentAndEntity<T: schwiftyes.Component>(entities: [schwiftyes.Entity], component: T.Type) throws -> (schwiftyes.Entity, T) {
        guard let foundEntity = entities.first(where: { entity in
            self.getComponent(entity, component) != nil
        }) else {
            throw ComponentAndEntityError.noEntity
        }

        guard let foundComponent = self.getComponent(foundEntity, T.self) else {
            throw ComponentAndEntityError.noComponent
        }

        return (foundEntity, foundComponent)
    }
}
