//
//  Country.swift
//  CountryInfo
//
//  Created by vako on 21.04.24.
//

import Foundation
// MARK: - Element
struct Element: Codable {
    let name: Name
    let tld: [String]?
    let cca2: String
    let ccn3: String?
    let cca3: String
    let cioc: String?
    let independent: Bool?
    let status: Status
    let unMember: Bool
//    let currencies: Currencies?
    let idd: Idd
    let capital: [String]?
    let altSpellings: [String]
    let region: Region
    let subregion: String?
    let languages: [String: String]?
    let translations: [String: Translation]
    let latlng: [Double]
    let landlocked: Bool
    let borders: [String]?
    let area: Double
    let demonyms: Demonyms?
    let flag: String
    let maps: Maps
    let population: Int
    let gini: [String: Double]?
    let fifa: String?
    let car: Car
    let timezones: [String]
    let continents: [Continent]
    let flags: Flags
    let coatOfArms: CoatOfArms
    let startOfWeek: StartOfWeek
    let capitalInfo: CapitalInfo
    let postalCode: PostalCode?
}

// MARK: - CapitalInfo
struct CapitalInfo: Codable {
    let latlng: [Double]?
}

// MARK: - Car
struct Car: Codable {
    let signs: [String]?
    let side: Side
}

enum Side: String, Codable {
    case sideLeft = "left"
    case sideRight = "right"
}

// MARK: - CoatOfArms
struct CoatOfArms: Codable {
    let png: String?
    let svg: String?
}

enum Continent: String, Codable {
    case africa = "Africa"
    case antarctica = "Antarctica"
    case asia = "Asia"
    case europe = "Europe"
    case northAmerica = "North America"
    case oceania = "Oceania"
    case southAmerica = "South America"
}

//// MARK: - Currencies
//struct Currencies: Codable {
//    let mdl, usd, eur, aud: Aed?
//    let mzn, brl, cve, xaf: Aed?
//    let all, nzd, ngn, gmd: Aed?
//    let sos, yer, myr, xcd: Aed?
//    let gbp, mga, dzd, mad: Aed?
//    let mru, pyg, lkr, zar: Aed?
//    let kwd, sll, rwf, syp: Aed?
//    let hnl, jod, tvd, npr: Aed?
//    let lrd, ggp, djf, fjd: Aed?
//    let nok, fkp, kzt, tmt: Aed?
//    let bgn, xpf, bbd, stn: Aed?
//    let bnd, sgd, btn, inr: Aed?
//    let ars, azn, mxn, gtq: Aed?
//    let kes, czk, gip, awg: Aed?
//    let aed, ssp, xof, shp: Aed?
//    let bwp, uzs, tnd, hkd: Aed?
//    let mkd, srd, sbd, uah: Aed?
//    let bam: BAM?
//    let irr, cuc, cup, ern: Aed?
//    let currenciesTRY, php, vuv, bob: Aed?
//    let ron, khr, zwl, jep: Aed?
//    let kgs, gyd, amd, lbp: Aed?
//    let dkk, pgk, zmw, ttd: Aed?
//    let pen, sek: Aed?
//    let sdg: BAM?
//    let omr, twd, mnt, tzs: Aed?
//    let cad, crc, cny, cop: Aed?
//    let mmk, rub, kpw, kyd: Aed?
//    let byn, szl, pln, chf: Aed?
//    let ves, pab, wst, fok: Aed?
//    let thb, bsd, top, bif: Aed?
//    let bhd, imp, htg, afn: Aed?
//    let ils, lyd, uyu, nio: Aed?
//    let ckd, lak, kid, ang: Aed?
//    let jmd, egp, clp, lsl: Aed?
//    let ghs, scr, aoa, bmd: Aed?
//    let pkr, sar, krw, etb: Aed?
//    let bdt, kmf, bzd, ugx: Aed?
//    let huf, isk, tjs, nad: Aed?
//    let rsd, mur, mop, mvr: Aed?
//    let idr, cdf, vnd, gnf: Aed?
//    let gel, mwk, iqd, jpy: Aed?
//    let dop, qar: Aed?
//
//    enum CodingKeys: String, CodingKey {
//        case mdl = "MDL"
//        case usd = "USD"
//        case eur = "EUR"
//        case aud = "AUD"
//        case mzn = "MZN"
//        case brl = "BRL"
//        case cve = "CVE"
//        case xaf = "XAF"
//        case all = "ALL"
//        case nzd = "NZD"
//        case ngn = "NGN"
//        case gmd = "GMD"
//        case sos = "SOS"
//        case yer = "YER"
//        case myr = "MYR"
//        case xcd = "XCD"
//        case gbp = "GBP"
//        case mga = "MGA"
//        case dzd = "DZD"
//        case mad = "MAD"
//        case mru = "MRU"
//        case pyg = "PYG"
//        case lkr = "LKR"
//        case zar = "ZAR"
//        case kwd = "KWD"
//        case sll = "SLL"
//        case rwf = "RWF"
//        case syp = "SYP"
//        case hnl = "HNL"
//        case jod = "JOD"
//        case tvd = "TVD"
//        case npr = "NPR"
//        case lrd = "LRD"
//        case ggp = "GGP"
//        case djf = "DJF"
//        case fjd = "FJD"
//        case nok = "NOK"
//        case fkp = "FKP"
//        case kzt = "KZT"
//        case tmt = "TMT"
//        case bgn = "BGN"
//        case xpf = "XPF"
//        case bbd = "BBD"
//        case stn = "STN"
//        case bnd = "BND"
//        case sgd = "SGD"
//        case btn = "BTN"
//        case inr = "INR"
//        case ars = "ARS"
//        case azn = "AZN"
//        case mxn = "MXN"
//        case gtq = "GTQ"
//        case kes = "KES"
//        case czk = "CZK"
//        case gip = "GIP"
//        case awg = "AWG"
//        case aed = "AED"
//        case ssp = "SSP"
//        case xof = "XOF"
//        case shp = "SHP"
//        case bwp = "BWP"
//        case uzs = "UZS"
//        case tnd = "TND"
//        case hkd = "HKD"
//        case mkd = "MKD"
//        case srd = "SRD"
//        case sbd = "SBD"
//        case uah = "UAH"
//        case bam = "BAM"
//        case irr = "IRR"
//        case cuc = "CUC"
//        case cup = "CUP"
//        case ern = "ERN"
//        case currenciesTRY = "TRY"
//        case php = "PHP"
//        case vuv = "VUV"
//        case bob = "BOB"
//        case ron = "RON"
//        case khr = "KHR"
//        case zwl = "ZWL"
//        case jep = "JEP"
//        case kgs = "KGS"
//        case gyd = "GYD"
//        case amd = "AMD"
//        case lbp = "LBP"
//        case dkk = "DKK"
//        case pgk = "PGK"
//        case zmw = "ZMW"
//        case ttd = "TTD"
//        case pen = "PEN"
//        case sek = "SEK"
//        case sdg = "SDG"
//        case omr = "OMR"
//        case twd = "TWD"
//        case mnt = "MNT"
//        case tzs = "TZS"
//        case cad = "CAD"
//        case crc = "CRC"
//        case cny = "CNY"
//        case cop = "COP"
//        case mmk = "MMK"
//        case rub = "RUB"
//        case kpw = "KPW"
//        case kyd = "KYD"
//        case byn = "BYN"
//        case szl = "SZL"
//        case pln = "PLN"
//        case chf = "CHF"
//        case ves = "VES"
//        case pab = "PAB"
//        case wst = "WST"
//        case fok = "FOK"
//        case thb = "THB"
//        case bsd = "BSD"
//        case top = "TOP"
//        case bif = "BIF"
//        case bhd = "BHD"
//        case imp = "IMP"
//        case htg = "HTG"
//        case afn = "AFN"
//        case ils = "ILS"
//        case lyd = "LYD"
//        case uyu = "UYU"
//        case nio = "NIO"
//        case ckd = "CKD"
//        case lak = "LAK"
//        case kid = "KID"
//        case ang = "ANG"
//        case jmd = "JMD"
//        case egp = "EGP"
//        case clp = "CLP"
//        case lsl = "LSL"
//        case ghs = "GHS"
//        case scr = "SCR"
//        case aoa = "AOA"
//        case bmd = "BMD"
//        case pkr = "PKR"
//        case sar = "SAR"
//        case krw = "KRW"
//        case etb = "ETB"
//        case bdt = "BDT"
//        case kmf = "KMF"
//        case bzd = "BZD"
//        case ugx = "UGX"
//        case huf = "HUF"
//        case isk = "ISK"
//        case tjs = "TJS"
//        case nad = "NAD"
//        case rsd = "RSD"
//        case mur = "MUR"
//        case mop = "MOP"
//        case mvr = "MVR"
//        case idr = "IDR"
//        case cdf = "CDF"
//        case vnd = "VND"
//        case gnf = "GNF"
//        case gel = "GEL"
//        case mwk = "MWK"
//        case iqd = "IQD"
//        case jpy = "JPY"
//        case dop = "DOP"
//        case qar = "QAR"
//    }
//}

// MARK: - Aed
struct Aed: Codable {
    let name, symbol: String
}

// MARK: - BAM
struct BAM: Codable {
    let name: String
}

// MARK: - Demonyms
struct Demonyms: Codable {
    let eng: Eng
    let fra: Eng?
}

// MARK: - Eng
struct Eng: Codable {
    let f, m: String
}

// MARK: - Flags
struct Flags: Codable {
    let png: String
    let svg: String
    let alt: String?
}

// MARK: - Idd
struct Idd: Codable {
    let root: String?
    let suffixes: [String]?
}

// MARK: - Maps
struct Maps: Codable {
    let googleMaps, openStreetMaps: String
}

// MARK: - Name
struct Name: Codable {
    let common, official: String
    let nativeName: [String: Translation]?
}

// MARK: - Translation
struct Translation: Codable {
    let official, common: String
}

// MARK: - PostalCode
struct PostalCode: Codable {
    let format: String
    let regex: String?
}

enum Region: String, Codable {
    case africa = "Africa"
    case americas = "Americas"
    case antarctic = "Antarctic"
    case asia = "Asia"
    case europe = "Europe"
    case oceania = "Oceania"
}

enum StartOfWeek: String, Codable {
    case monday = "monday"
    case saturday = "saturday"
    case sunday = "sunday"
}

enum Status: String, Codable {
    case officiallyAssigned = "officially-assigned"
    case userAssigned = "user-assigned"
}

typealias Empty = [Element]
