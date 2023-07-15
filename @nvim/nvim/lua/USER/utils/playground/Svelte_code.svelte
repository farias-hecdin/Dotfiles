<script>
  let name = 'world';

  function greet() {
    console.log(`Hello, ${name}!`);
  }
</script>

<h1>Hello {name}!</h1>
<button on:click={greet}>Greet</button>
