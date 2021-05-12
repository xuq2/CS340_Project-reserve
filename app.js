const express = require('express')
const exphbs = require('express-handlebars')
var app = express()
const port = 3000

app.engine('hbs', exphbs({
  extname: 'hbs',
  defaultLayout: 'main'
}))

app.set('view engine', 'hbs')

// Homepage
app.get('/', (req, res) => {
  res.render('index')

})

// Movies & Auditoriums page
app.get('/movies', (req, res) => {
  res.render('moviesAuditoriums')
})

// Tickets page
app.get('/tickets', (req, res) => {
  res.render('tickets')
})

// Theaters page
app.get('/theaters', (req, res) => {
  res.render('theaters')
})

// Customers page
app.get('/customers', (req, res) => {
  res.render('customers')
})

// Projector page
app.get('/projectors', (req, res) => {
  res.render('projectorEquipments')
})

app.listen(port, () => {
  console.log(
    `Express started on http://flip1.engr.oregonstate.edu:${port}; press Ctrl-C to terminate.`
  )
})
