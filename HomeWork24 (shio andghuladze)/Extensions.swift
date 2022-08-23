//
//  Extensions.swift
//  HomeWork24 (shio andghuladze)
//
//  Created by shio andghuladze on 23.08.22.
//

import Foundation

extension FileManager {
    
    func getAllFiles(dir: String? = nil)-> [String]{
        let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
        if let dir = dir {
            let directory = (path as NSString).appendingPathComponent(dir)
            return (try? contentsOfDirectory(atPath: directory).filter{ !$0.isEmpty }) ?? [String]()
        }
        return (try? contentsOfDirectory(atPath: path).filter{ !$0.isEmpty }) ?? [String]()
    }
    
    func createDirectoryInDocuments(name: String){
        let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
        let dir = (path as NSString).appendingPathComponent(name)
        try? createDirectory(atPath: dir, withIntermediateDirectories: true, attributes: nil)
    }
    
    func createTextFileIn(directoryInsideDocuments: String, textFileName: String, text: String){
        let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
        let dir = (path as NSString).appendingPathComponent(directoryInsideDocuments)
        let file = (dir as NSString).appendingPathComponent(textFileName)
        let data = Data(text.utf8)
        createFile(atPath: file, contents: data, attributes: nil)
    }
    
    func deleteFile(dir: String){
        let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
        let file = (path as NSString).appendingPathComponent(dir)
        try? removeItem(atPath: file)
    }
    
    func getFileContent(directoryInsideDocuments: String, textFileName: String)-> String?{
        let path = urls(for: .documentDirectory, in: .userDomainMask).first
        let dir = path?.appendingPathComponent(directoryInsideDocuments)
        let file = dir?.appendingPathComponent(textFileName)
        if let file = file {
            return try? String(contentsOf: file)
        }
        return nil
    }
    
}
