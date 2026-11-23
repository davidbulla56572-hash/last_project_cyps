package grupo3;

import com.intuit.karate.junit5.Karate;

public class Grupo3Test {
    @Karate.Test
    Karate ejecutarGrupo3() {
        return Karate.run("classpath:grupo3/contactos.feature", "classpath:grupo3/seguridad.feature", "classpath:grupo3/usuarios.feature");
    }
}
