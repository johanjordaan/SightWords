const fs = require('fs')
const parser = require('xml2json')
const _ = require('lodash')
const ejs = require('ejs')

const xml = fs.readFileSync('../SightWords/SightWords.xcdatamodeld/SightWords.xcdatamodel/contents','utf8')
const template =  fs.readFileSync('./template.swift','utf8')
const testTemplate =  fs.readFileSync('./template.test.swift','utf8')

var json = JSON.parse(parser.toJson(xml))

const fromDBType = (value) => {
  const lookup =  {
    'Integer 16':'Int',
  }
  
  return lookup[value]||value
}

const fromDBBool =(value) => {
  return value === 'YES'
}

const ucfirst = (n) => {
  return n.charAt(0).toUpperCase() + n.slice(1)
}



const parameterList = (entity,exclude) => {
  const attributes = entity.attribute.filter(i=>!_.includes(exclude||[],i.name)).map((a)=>{
    return  {name:a.name,type:fromDBType(a.attributeType),relation:false,toMany:false}
  })
  const relationships = entity.relationship.filter((r)=>r.destinationEntity!==undefined).map((r)=>{
    if(r.toMany==="YES") {
      return  {name:r.name,type:`[${r.destinationEntity}]`,relation:true,toMany:true}
    } else {
      return  {name:r.name,type:`${r.destinationEntity}`,relation:true,toMany:false}
    }
  })
  return attributes.concat(relationships)
}



//_.each(json.model.entity,(entity)=>{
  
  /*console.log('==========================')
  console.log(entity.name)
  console.log('Attributes------------------')  
  _.each(entity.attribute,(attribute)=>{
    console.log(
      attribute.name,
      attribute.attributeType,
      attribute.defaultValueString,
      attribute.optional
    )
  })
  console.log('Relationships---------------')  
  
  _.each(entity.relationship,(relationship)=>{
    console.log(
      relationship.name,
      mapBool(relationship.toMany||"NO"),
      relationship.destinationEntity,
      relationship.inverseName,
      relationship.inverseEntity
    )
  })*/
  
  //if(!_.isArray(entity.relationship)) {
  //  entity.relationship = [entity.relationship]
  //}
  
  
  //const output = ejs.render(template,{entity,fromDBType,parameterList,ucfirst})
  //console.log(output)
  //fs.writeFileSync(`../SightWords/dao/${entity.name}.swift`,output)

  //console.log('==========================')
//})


const entities = _.map(json.model.entity,(entity)=>{
  const name = entity.name
  const attributeFields =  _.map(entity.attribute,(attribute)=>{
    return {
      isrelstionship:false,
      hasMany:null,
      name:attribute.name,
      pascalName:ucfirst(attribute.name),
      type:fromDBType(attribute.attributeType),
      itemType:fromDBType(attribute.attributeType),
      default:attribute.defaultValueString,
      optional:fromDBBool(attribute.optional),
    }
  })

  // Realtionships can either be an array or a sinfle object
  // 
  if(!_.isArray(entity.relationship)) {
    entity.relationship = [entity.relationship]
  }
  const relationshipFields =  _.map(entity.relationship,(relationship)=>{
    const hasMany =  fromDBBool(relationship.toMany) 
    
    return {
      isrelstionship:true,
      hasMany:hasMany,
      name:relationship.name,
      pascalName:ucfirst(relationship.name),
      type:hasMany?`[${relationship.destinationEntity}]`:relationship.destinationEntity,
      itemType:relationship.destinationEntity,
      default:null,
      optional:null,
    }
  })

  return {
    name,
    fields:attributeFields.concat(relationshipFields),
  }
})

_.each(entities,(entity)=>{
  const source = ejs.render(template,{entity})
  const testSource = ejs.render(testTemplate,{entity})
  console.log(source)
  console.log(testSource)
  console.log("-----------------------------")
  fs.writeFileSync(`../SightWords/dao/${entity.name}.swift`,source)
  fs.writeFileSync(`../SightWordsTests/dao/${entity.name}Tests.swift`,testSource)
})



