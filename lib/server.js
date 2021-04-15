const http = require('http')

const server = http.createServer()

const url = 'https://gravatar.com/avatar/d2f7a7cf1a9eb36f585ef384f9e02333?s=400&d=robohash&r=x'

const result = [
  {
    documentName: 'Студентський \n квиток',
    documentStatus: 'КВ24242424 \n\n Дійсний до: \n 01.01.2077 \n\n Форма навчання: \n денна',
    studyPlace: 'Національний технічний університет \n України "Київський політехнічний \n інститут імені Ігоря Сікорського',
    userName: 'Сімонов \n Валерій \n Павлович',
    imgUrl: 'https://gravatar.com/avatar/7e2fd80de2e6c4f49372e1cd6a0d4ae0?s=400&d=robohash&r=x'
  },
  {
    documentName: 'Студентський \n квиток',
    documentStatus: 'КВ24242424 \n\n Дійсний до: \n 01.01.2077 \n\n Форма навчання: \n денна',
    studyPlace: 'Національний технічний університет \n України "Київський політехнічний \n інститут імені Ігоря Сікорського',
    userName: 'Сімонов \n Валерій \n Павлович',
    imgUrl: 'https://gravatar.com/avatar/e54d32f87a182323d27ef590c72bebe5?s=400&d=robohash&r=x'
  },
  {
    documentName: 'Студентський \n квиток',
    documentStatus: 'КВ24242424 \n\n Дійсний до: \n 01.01.2077 \n\n Форма навчання: \n денна',
     studyPlace: 'Національний технічний університет \n України "Київський політехнічний \n інститут імені Ігоря Сікорського',
    userName: 'Сімонов \n Валерій \n Павлович',
    imgUrl: 'https://gravatar.com/avatar/d01636c2b2c51dc6f73d904d5b8920ec?s=400&d=robohash&r=x'
  }
]

server.on('request', (req, res) => {
    res.writeHead(200, {'Content-Type': 'text/json'})
    res.end(JSON.stringify(result))
})

server.listen(3000, () => console.log('Server started'))