//
//  AvailableSpaceShip+JsonGen.swift
//
//  Auto generated by swift-json-gen on Tue, 18 Aug 2015 18:32:44 GMT
//

import Foundation
import UIKit

extension AvailableSpaceship {
  static func decodeJson(json: AnyObject) -> AvailableSpaceship? {
    let _dict = json as? [String : AnyObject]
    if _dict == nil { return nil }
    let dict = _dict!

    let id_field: AnyObject? = dict["id"]
    if id_field == nil { assertionFailure("field 'id' is missing"); return nil }
    let id_optional: String? = String.decodeJson(id_field!)
    if id_optional == nil { assertionFailure("field 'id' is not String"); return nil }
    let id: String = id_optional!

    let pictureShip_field: AnyObject? = dict["pictureShip"]
    if pictureShip_field == nil { assertionFailure("field 'pictureShip' is missing"); return nil }
    let pictureShip_optional: NSURL? = NSURL.decodeJson(pictureShip_field!)
    if pictureShip_optional == nil { assertionFailure("field 'pictureShip' is not NSURL"); return nil }
    let pictureShip: NSURL = pictureShip_optional!

    let typeSpaceShip_field: AnyObject? = dict["typeSpaceShip"]
    if typeSpaceShip_field == nil { assertionFailure("field 'typeSpaceShip' is missing"); return nil }
    let typeSpaceShip_optional: String? = String.decodeJson(typeSpaceShip_field!)
    if typeSpaceShip_optional == nil { assertionFailure("field 'typeSpaceShip' is not String"); return nil }
    let typeSpaceShip: String = typeSpaceShip_optional!

    let planet_field: AnyObject? = dict["planet"]
    if planet_field == nil { assertionFailure("field 'planet' is missing"); return nil }
    let planet_optional: String? = String.decodeJson(planet_field!)
    if planet_optional == nil { assertionFailure("field 'planet' is not String"); return nil }
    let planet: String = planet_optional!

    return AvailableSpaceship(id: id, pictureShip: pictureShip, typeSpaceship: typeSpaceShip, planet: planet)
  }

  func encodeJson() -> AnyObject {
    var dict: [String: AnyObject] = [:]

    dict["id"] = id.encodeJson()
    dict["pictureShip"] = pictureShip.encodeJson()
    dict["typeSpaceShip"] = typeSpaceship.encodeJson()
    dict["planet"] = planet.encodeJson()

    return dict
  }
}