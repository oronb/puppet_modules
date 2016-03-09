#init.pp

class test {
       file {'/tmp/test':
             content => 'test succeed!'
       }
}
