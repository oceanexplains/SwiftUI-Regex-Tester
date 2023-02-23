//
//  ContentView.swift
//  SwiftUIRegex
//
//  Created by Ocean on 2/23/23.
//

import SwiftUI

struct ContentView: View {
    
    @State private var countMatches = "0"
    @State private var regexInput = "(?<=^\\[download\\].)[0-9.]+\\%"
    @State private var inputString = "[download] 12.5% of ~4,62KiB at Unknown speed ETA 00:00"
    @State private var outputString = ""
   
    @State private var startIndex = "0"
    @State private var matchLength = "0"
    
    var body: some View {
        VStack {
            HStack {
                Text("Regular Expression:")
                TextField("Enter regular expression here", text: $regexInput)
            }
            HStack {
                Text("Sample Text:")
                TextField("Enter sample text here", text: $inputString)
            }
            Button(action: {
                self.calculateMatches()
            }, label: {
                Text("Test Regex")
            })
            HStack {
                Text("Matches:")
                Text(countMatches)
                Spacer()
                Text("Start Index:")
                Text(startIndex)
                Spacer()
                Text("Match Length:")
                Text(matchLength)
            }
            HStack {
                Text("Output:")
                Text(outputString)
                    .padding(3)
                    .border(Color.gray)
            }
        }
        .padding()
    }
    func calculateMatches() {
        outputString = ""
        
        let pattern = regexInput
        let str = inputString
        
        do{
            //create regex and find matches
            let regex = try NSRegularExpression(pattern: pattern, options: [])
            let matches = regex.matches(in: str, options: [], range: NSRange(location: 0, length: str.count))//characters.count))
            
            if(matches.count > 0){
                //Get location of first match and length of match
                let range = matches[0].range(at: 0)
                
                //convert range to index
                var index = str.index(str.startIndex, offsetBy: range.location + range.length)
                
                //get substring from index
                var outputStr = str[..<index]//str.substring(to: index)
                index = str.index(str.startIndex, offsetBy: range.location)
                outputStr = outputStr[index...]//.substring(from: index)
                
                //set GUI
                countMatches = "\(matches.count)"
                startIndex = "\(range.location)"
                matchLength = "\(range.length)"
                outputString = String(outputStr)
            } else {
                outputString = ""
                countMatches = "0"
                startIndex = "-"
                matchLength = "-"
            }
            
        } catch _ {
            outputString = "-- Bad reggex --"
            countMatches = "0"
            startIndex = "-"
            matchLength = "-"
        }
    }
}

