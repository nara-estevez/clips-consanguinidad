; definicion de persona (nombre, sexo, y progenitores)

(deftemplate Persona
  (field Nombre)
  (field Sexo)
  (field Padre)
  (field Madre)
)

; caso definido de familia

(deffacts Familia
  (Persona (Nombre Isabel) (Sexo mujer))	
  (Persona (Nombre Felipe) (Sexo hombre))
  (Persona (Nombre Carlos) (Sexo hombre) (Padre Felipe) (Madre Isabel))
  (Persona (Nombre Ana) (Sexo mujer) (Padre Felipe) (Madre Isabel))
  (Persona (Nombre Andres) (Sexo hombre) (Padre Felipe) (Madre Isabel))
  (Persona (Nombre Eduardo) (Sexo hombre) (Padre Felipe) (Madre Isabel))

  (Persona (Nombre Guillermo) (Sexo hombre) (Padre Carlos) (Madre Diana))
  (Persona (Nombre Enrique) (Sexo hombre) (Padre Carlos) (Madre Diana))
  
  (Persona (Nombre Jorge) (Sexo hombre) (Padre Guillermo))
  (Persona (Nombre Carlota) (Sexo mujer) (Padre Guillermo))
  (Persona (Nombre Luis) (Sexo hombre) (Padre Guillermo))

  (Persona (Nombre Archie) (Sexo hombre) (Padre Enrique))
  (Persona (Nombre Lillibet) (Sexo mujer) (Padre Enrique))

  ; expansion 2.4
  (Persona (Nombre Camilla) (Sexo mujer))
  (Persona (Nombre Diana) (Sexo mujer))

  (Persona (Nombre Timothy) (Sexo hombre))
  (Persona (Nombre Mark) (Sexo hombre))

  (Persona (Nombre Sarah) (Sexo mujer))

  (Persona (Nombre Sofia) (Sexo mujer))
)


