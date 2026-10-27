; relaciones de consanguinidad
; hermanos

(defrule SonHermanos
  ?Hermano1 <- (Persona (Nombre ?Nombre1) (Madre ?Madre) (Padre ?Padre))
  ?Hermano2 <- (Persona (Nombre ?Nombre2 & ~?Nombre1) (Madre ?Madre) (Padre ?Padre))
	
  ; si no conocemos ni padre ni madre, no asumimos que son hermanos
  (test 
  	(or
  	  (neq ?Padre nil)
  	  (neq ?Madre nil)
  	)
  )

  ; comprobamos que los hechos sean en orden ascendiente (evitamos duplicados)
  (test 
  	(< 
	  (fact-index ?Hermano1)
	  (fact-index ?Hermano2)
	)
  )
  =>
  (printout t ?Nombre1 " y " ?Nombre2 " son hermanos/as." crlf)
)

; tios/tias y sobrinos/sobrinas (equivalentes)

(defrule TioSobrino
  (Persona (Nombre ?NombreProgenitor) (Madre ?Abuela) (Padre ?Abuelo))
  (Persona (Nombre ?Sobrino) (Madre ?MadreSobrino) (Padre ?PadreSobrino))

  ; comprobamos que es progenitor-hijo
  (test
  	(or
	  (and
		(neq ?MadreSobrino nil)
		(eq ?NombreProgenitor ?MadreSobrino)
	  )
	  (and
		(neq ?PadreSobrino nil)
		(eq ?NombreProgenitor ?PadreSobrino)
	  )
	)
  )
	
  (Persona (Nombre ?NombreTio & ~?NombreProgenitor) (Madre ?AbuelaTio) (Padre ?AbueloTio))
	
  ; comprobamos que son hermanos
  (test
  	(or
	  (and
		(neq ?Abuela nil)
		(eq ?Abuela ?AbuelaTio)
	  )
	  (and
		(neq ?Abuelo nil)
		(eq ?Abuelo ?AbueloTio)
	  )
	)
  )
  =>
  (printout t ?NombreTio " es tio/tia de " ?Sobrino crlf)
  (printout t ?Sobrino " es sobrino/sobrina de " ?NombreTio crlf)
)

; primos/primas

(defrule EsPrimo
  ?Progenitor <- (Persona (Nombre ?NombreProgenitor) (Madre ?Abuela1) (Padre ?Abuelo1))
  ?Primo1 <- (Persona (Nombre ?NombrePrimo1) (Madre ?MadrePrimo1) (Padre ?PadrePrimo1))

  ; comprobamos que es progenitor-hijo
  (test
	(or
	  (and
		(neq ?MadrePrimo1 nil)
		(eq ?NombreProgenitor ?MadrePrimo1)
	  )
	  (and
		(neq ?PadrePrimo1 nil)
	    (eq ?NombreProgenitor ?PadrePrimo1)
	  )
	)
  )
	
  ?Tio <- (Persona (Nombre ?NombreTio & ~?NombreProgenitor) (Madre ?Abuela2) (Padre ?Abuelo2))
	
  ; comprobamos que son hermanos (progenitor-tio)
  (test
  	(or
	  (and
		(neq ?Abuela1 nil)
		(eq ?Abuela1 ?Abuela2)
	  )
	  (and
		(neq ?Abuelo1 nil)
		(eq ?Abuelo1 ?Abuelo2)
	  )
	)
  )

  ?Primo2 <- (Persona (Nombre ?NombrePrimo2) (Madre ?MadrePrimo2) (Padre ?PadrePrimo2))

  ; comprobamos que es primo (su madre o padre es tio/tia de primo1)
  (test
	(or
	  (and
		(neq ?MadrePrimo2 nil)
		(eq ?NombreTio ?MadrePrimo2)	
	  )
	  (and
		(neq ?PadrePrimo2 nil)
		(eq ?NombreTio ?PadrePrimo2)
	  )
	)
  )

  ; misma comprobacion que en hermanos para evitar duplicados
  (test 
	(< 
	  (fact-index ?Primo1)
	  (fact-index ?Primo2)
	)
  )
  =>
  (printout t ?NombrePrimo1 " y " ?NombrePrimo2 " son primos/primas." crlf)
)

; abuelo/abuela

(defrule EsAbuelo
  (Persona (Nombre ?NombreProgenitor) (Madre ?Abuela) (Padre ?Abuelo))
  (Persona (Nombre ?NombreNieto) (Madre ?MadreNieto) (Padre ?PadreNieto))

  ; comprobamos que es progenitor-hijo
  (test
	(or
	  (and
		(neq ?MadreNieto nil)
		(eq ?NombreProgenitor ?MadreNieto)
	  )
	  (and
		(neq ?PadreNieto nil)
	    (eq ?NombreProgenitor ?PadreNieto)
	  )
	)
  )

  ; comprobamos si exite abuelo o abuela no nulos
  (test
    (or
      (neq ?Abuela nil)
      (neq ?Abuelo nil)
    )
  )
  =>
  (if (neq ?Abuela nil) then 
    (printout t ?Abuela " es abuela de " ?NombreNieto crlf)
  )
  (if (neq ?Abuelo nil) then
    (printout t ?Abuelo " es abuelo de " ?NombreNieto crlf)
  )
)
