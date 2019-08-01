const fs = require('fs')

const wordTemplate = (rank,word)=>`SightWord(word: "${word}", rank: ${rank} )`
const fileTemplate = (words,d=new Date())=> `
//  Words.swift
//  SightWords
//
//  Generated by Johan Jordaan on ${d.getDate()}/${d.getMonth()+1}/${d.getFullYear()}.
//  Copyright © 2019 Johan Jordaan. All rights reserved.
//
import Foundation

let words = [
  ${words.map(([rank,word])=>wordTemplate(rank,word)).join(',\n  ')}
]
`

const data = fs.readFileSync('./wordlist.csv','utf8')
const lines = data.replace(/\r/g,'').split('\n')
const rows = lines.filter(line=>line.trim().length>1).map(line=>line.split(','))

const top = (limit, rows) => {
  return rows.filter(i=>Number(i[0])<=limit)
}

const selectedWords = top(5,rows)

const code = fileTemplate(selectedWords)
fs.writeFileSync('../SightWords/data/Words.swift',code)

console.log(code)

