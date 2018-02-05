//
//  NatrualLanguageProcess.swift
//  DemoSearch
//
//  Created by Gemma Jing on 11/11/2017.
//  Copyright © 2017 Gemma Jing. All rights reserved.
//

import Foundation

class NaturalLanguageProcess {
    func findInformation(speech: String) -> [String: String] {
        
        let tokenOptions = NSLinguisticTagger.Options.omitWhitespace.rawValue | NSLinguisticTagger.Options.omitPunctuation.rawValue

        let tokenTagger = NSLinguisticTagger(tagSchemes: NSLinguisticTagger.availableTagSchemes(forLanguage: "en"), options: Int(tokenOptions))
        
        tokenTagger.string = speech
        let textRange = NSRange(location: 0, length: speech.utf16.count)
        
        var food: [String: String] = ["Noun": "", "Determiner": ""]
        // enumerate iver text to get the tages and tokens
        tokenTagger.enumerateTags(in: textRange, scheme: .lexicalClass, options: NSLinguisticTagger.Options(rawValue: tokenOptions)) { tag, tokenRange, sentenceRange, stop in
            let convertTag = tag!._rawValue
            
            if(String(convertTag) == "Noun"){
                let word = (speech as NSString).substring(with: tokenRange)
                //print it in a text box in view
                if(food["Noun"] == ""){
                    food["Noun"] = String(word)
                }
                else{
                    food["Noun"]?.append(" ")
                    food["Noun"]?.append(String(word))
                }
            }
            if(String(convertTag) == "Determiner"){
                let word = (speech as NSString).substring(with: tokenRange)
                //print it in a text box in view
                food["Determiner"] = String(word)
            }
        }
        return food
    }
}
